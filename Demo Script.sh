# CDK Overview

# https://developers.redhat.com/products/cdk/overview/

######### Vagrant Section

vagrant up

# Discuss registration

vagrant ssh

# sudo subscription-manager list

# Show access to home directory
ls /home/gnunn

####### Docker Section

# Get info about system
docker info

# get a list of images in local docker registry
docker images

# Get a list of running containers
docker ps

# Get the logs for the HAProxy container
docker logs 3b727d51d9d2

# docker search
docker search wildfly

###### OpenShift section

# Login into web application

# Talk about projects, concepts

# Show where CLI tool can be downloaded

# OC login
oc login https://192.168.121.2:8443

# oc version
oc version

########### Insult application section

# Create a new project
oc new-project insultapp --display-name="Elizabethan Insults"

# Show how it switches us to the project space
oc status

# Add wildfly template
oc create -f https://raw.githubusercontent.com/luciddreamz/library/master/official/wildfly/image-streams/wildfly-centos7.json

# Build application, tilde used to indicate that we want to use s2i process
oc new-app wildfly:latest~https://github.com/gnunn1/book-insultapp.git --name='insults'
# oc new-app docker.io/openshift/wildfly-100-centos7:latest~https://github.com/gnunn1/book-insultapp.git --name='insults'

# Expose service via a route
oc expose service insults

# List routes
oc get route

# Try out application at URL

# Enhance application with database
# oc create -f https://raw.githubusercontent.com/openshift/openshift-ansible/e092de714dc09a86a0ff26c648eec2033a3b9952/roles/openshift_examples/files/examples/v1.0/db-templates/postgresql-persistent-template.json
oc create -f https://raw.githubusercontent.com/luciddreamz/library/master/official/postgresql/postgresql-persistent-template.json

# Create database in project
oc new-app --template=postgresql-persistent -p DATABASE_SERVICE_NAME=postgresql -p POSTGRESQL_USER=insult -p POSTGRESQL_PASSWORD=insult -p POSTGRESQL_DATABASE=insults 

# Add environment variables to insults deployment config so it knows where to look up service
oc set env dc insults -e POSTGRESQL_USER=insult -e POSTGRESQL_DATABASE=insults -e PGPASSWORD=insult

# Update code here

# Start build
oc start-build insults

# Shell prompt on pod
oc rsh <pod>

# Update database with schema, run in insults
psql -h $POSTGRESQL_SERVICE_HOST -p $POSTGRESQL_SERVICE_PORT -U $POSTGRESQL_USER $POSTGRESQL_DATABASE < insults.sql

# Uncomment pom.xml and code
oc start-build insults

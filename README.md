# Easyrec v1.0.4
The easyrec project is an open source recommendation system providing a low barrier entrance to high quality recommendations to any website with personalization needs. 


## Docker image for Easyrec Server 1.0

[![Docker Hub; vetdeit/easyrec-docker](https://img.shields.io/badge/dockerhub-verdeit%2Feasyrec--docker-brightgreen.svg)](https://registry.hub.docker.com/u/verdeit/easyrec-docker)

## What is Easyrec?

The easyrec project is an open source recommendation system providing a low barrier entrance to high quality recommendations to any website with personalization needs. The access to easyrec is provided through Web services assuring an easy and quick integration. Immediate deployment is possible for web sites (e.g. scripts enclosing API calls, placed in the client's pages, see below). Its focus is simple integration; In most cases, the web-based administration interface should be sufficient for configuring easyrec.
easyrec is an open source Web application that provides personalized recommendations using RESTful Web services to be integrated into Web enabled applications. It is distributed under the GNU General Public License by the Studio Smart Agent Technologies and hosted at SourceForge. It is written in Java, uses a MySQL database and comes with an administration tool.

In this wiki you will find the documentation of the easiest to use open source recommender. If you have any further questions don't hesitate to contact us at the [forums](http://sourceforge.net/apps/phpbb/easyrec/). If you are completely new to easyrec you may want to see how to [get started](http://easyrec.sourceforge.net/wiki/index.php/Getting_Started). You might also want to have a glimpse at the [frequently asked questions(FAQ)](http://easyrec.sourceforge.net/wiki/index.php/FAQ).
For instructions on installing easyrec on your server, read the [Installation Guide](http://easyrec.sourceforge.net/wiki/index.php/Installation_Guide).

## Features

A major feature of easyrec is a set of usage statistics and other business relevant information presented via an administration and management interface. Furthermore, the easyrec administrator is supported by a variety of administration and configuration functions including the manual import or adaptation of business rules. Integrators and developers benefit from the lightweight Web service APIs (REST and SOAP) as well as the guided installation wizard.
easyrec provides the following personalization services:
unpersonalized recommendations of the form "other users also bought/viewed/...", etc.
- personalized recommendation depending on individual preferences
- rankings such as "most bought items", "most viewed...", etc.
- manual clustering of the items (e.g. SUMMER SALE 2011)
- using item types (e.g. BOOK, DVD, MP3) for in type-specific recommendations
- a plugin system for the rule generators

Additionally, as an integration showcase, a drupal ubercart extension was developed. For more information about the history of easyrec read the [wikipedia article](http://en.wikipedia.org/wiki/Easyrec).

## Preview
We're hosting a demo instance, so if you want to play around with easyrec start at [http://easyrec.org](http://easyrec.org/) and create an account. Then check the easyrec version deployed on our server and read the documentation for this version to get started.

## Docs
The following links lead you to the documentations of the given version:
- [Documentation](http://easyrec.sourceforge.net/wiki/index.php/Documentation_v0.99) for version 0.99 *upcoming version*
- [Documentation](http://easyrec.sourceforge.net/wiki/index.php/Documentation_v0.98) for version 0.98 **current version**
- [Documentation](http://easyrec.sourceforge.net/wiki/index.php/Documentation_v0.97) for version 0.97
- [Documentation](http://easyrec.sourceforge.net/wiki/index.php/Documentation_v0.96) for version 0.96
- [Documentation](http://easyrec.sourceforge.net/wiki/index.php/Integration_Guide_v0.95) for version 0.95


Container based on [![Docker Hub; nimmis/mariadb](https://img.shields.io/badge/dockerhub-nimmis%2Fmariadb-green.svg)](https://registry.hub.docker.com/u/nimmis/mariadb) with working init process and syslog. For more information on how to set upp services, please read the documentation for [nimmis/mariadb](https://registry.hub.docker.com/u/nimmis/mariadb)


## Starting the container

To run the lastest stable version of this docker image run

	docker run -d verdeit/easyrec-docker

To expose the web server and database to the external interface run

	docker run -d -p 3306:3306 -p 8080:8080 --name easyrec verdeit/easyrec-docker
  docker exec -d easyrec /etc/init.d/tomcat.sh start

After tomcat startup, go to apache home

  http://localhost:8080

Easyrec path

  http://localhost:8080/easyrec-web/

### Installing Easyrec

Mysql user data:

  Database Host : localhost
  Database Name : easyrec
  User Name : easyrecuser
  Password : admin

Check MySQL improvements and initialize database. This process can last between 1,5 to 3 minutes.
Rest API is checked by default. Check if is development environment or/and continue. Wait for database migrations.
Next, create the admin user account. whala! If u are in easyrec dashboard, that`s all be ok.
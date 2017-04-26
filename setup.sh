#!/bin/bash

sudo yum install -y wget epel-release
sudo yum install gcc-c++ gcc make bison flex binutils-devel openldap-devel libicu-devel libxslt-devel libarchive-devel boost-devel openssl-devel apr-devel apr-util-devel hiredis-devel numactl-devel mariadb-devel libevent-devel tbb-devel atlas-devel python34 libmemcached-devel sqlite-devel v8-devel python-devel python34-devel java-1.8.0-openjdk-devel R-core-devel R-Rcpp-devel R-inline R-RInside-devel -y
sudo wget -O /etc/pki/rpm-gpg/RPM-GPG-KEY-cern https://raw.githubusercontent.com/cms-sw/cms-docker/master/slc7-builder/RPM-GPG-KEY-cern
sudo wget -O /etc/yum.repos.d/slc6-devtoolset.repo http://linuxsoft.cern.ch/cern/devtoolset/slc6-devtoolset.repo
sudo yum install -y devtoolset-2
scl enable devtoolset-2 bash

#!/bin/bash

# GNU Sqltutor Installer
# Copyright (C) 2010, 2017  Free Software Foundation, Inc.
#
# This file is part of GNU Sqltutor
# Contributed by Ales Cepek <cepek@gnu.org>
#
# GNU Sqltutor is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# GNU Sqltutor is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with GNU Sqltutor.  If not, see <http://www.gnu.org/licenses/>.


# variables and implicit values from configure.ac
SQLTUTOR_DATABASE=sqltutor
SQLTUTOR_WWW_USER=sqlquiz
SQLTUTOR_PASSWORD=sqlkrok
SQLTUTOR_WWW_EXEC=sqlexec
SQLTUTOR_PASSEXEC=sqlkrok

# installer variables
INSTALLER_VERSION=1.4
GIT_SQLTUTOR=./sqltutor
GIT_DATASETS=./datasets
BINDIR=/usr/lib/cgi-bin
INFODIR=/usr/share/info
POSTGIS=
POSTGIS_PATH=/usr/share/postgresql/9.6/contrib/postgis-2.3
SED_INPUT=/tmp/$$-sqltutor-installer-sed-input


# get_word prompt variable default
function get_word() {
    local word
    read  -e -p "$1" -i "$3" word
    eval  "$2=$word"
}

function warning() {
    echo -e "WARNING:" $1 "\n"
}

function get_repo() {
    while :
    do
	local repo
	get_directory "$1" repo "$3"
	#if ! (cd $repo && git diff 2>/dev/null); then
	#    warning "$repo is not a git repository"
	#    continue
	#fi
	if [ ! -f $repo/autogen.sh ]; then
	    warning "File autogen.sh does not exist in the directory $repo"
	    continue
	fi
	eval "$2=$repo"
	break
    done
}

function get_directory() {
    local tmp=...tmp.sqltutor.tmp...
    while :
    do
	local directory
	get_word "$1" directory "$3"
	if [ ! -d $directory ]; then
	    warning "$directory is  not a directory"
	    continue;
	fi
	if [ "x$4" == "x" ] && ! ( touch $directory/$tmp 2>/dev/null ); then
	    warning "you do not have rights to write in $directory directory"
	    continue;
	fi
	eval "$2=$directory"
	break
    done
    rm -f $directory/$tmp
}

function postgis() {
    while [ "x$POSTGIS" != "xy" ] && [ "x$POSTGIS" != "xn" ];
    do
	get_word "Do you want to enable PostGIS extension? (y/n) : " POSTGIS n
    done
    if [ "x$POSTGIS" != "xy" ]; then
	POSTGIS=
    else
	POSTGIS=--enable-postgis
	create_geometry
    fi
}

function create_geometry() {
    echo
    local t=""
    while [ "x$t" == "x" ];
    do
	get_directory "The PostGIS directory? " POSTGIS_PATH $POSTGIS_PATH ro
	t="ok"
	if [ ! -f $POSTGIS_PATH/postgis.sql ]; then
	    warning "File $POSTGIS_PATH/postgis.sql does not exist"
	    t=""
	fi
	if [ ! -f $POSTGIS_PATH/spatial_ref_sys.sql ]; then
	    warning "File $POSTGIS_PATH/spatial_ref_sys.sql does not exist"
	    t=""
	fi
    done
}

function create_user() {
    local user=$1
    local pass=$2
    local test=$(sudo -u postgres psql -A -t -c "select count(*) from pg_user where usename='$user'")
    if [ "x$test" == "x1" ]; then
	echo Sqluser $user already exists ...
    else
	echo Creating sqltutor user $user ...
	sudo -u postgres psql -c "CREATE ROLE $user LOGIN;"
    fi
    sudo -u postgres psql -c "ALTER USER $user WITH PASSWORD '$pass';"
}

function preconfigure() {
    echo
    echo Setting up configure files ...
    (cd $GIT_SQLTUTOR && rm -f configure && ./autogen.sh)
    (cd $GIT_DATASETS && rm -f configure && ./autogen.sh)
cat > $SED_INPUT <<EOF
s/^SQLTUTOR_DATABASE=.*/SQLTUTOR_DATABASE=$SQLTUTOR_DATABASE/
s/^SQLTUTOR_WWW_USER=.*/SQLTUTOR_WWW_USER=$SQLTUTOR_WWW_USER/
s/^SQLTUTOR_PASSWORD=.*/SQLTUTOR_PASSWORD=$SQLTUTOR_PASSWORD/
s/^SQLTUTOR_WWW_EXEC=.*/SQLTUTOR_WWW_EXEC=$SQLTUTOR_WWW_EXEC/
s/^SQLTUTOR_PASSEXEC=.*/SQLTUTOR_PASSEXEC=$SQLTUTOR_PASSEXEC/
EOF
    sed -i -f $SED_INPUT $GIT_SQLTUTOR/configure $GIT_DATASETS/configure
    rm -f $SED_INPUT
}

cat <<EOF
GNU Sqltutor installer v. $INSTALLER_VERSION
=============================

To install sqltutor you must have git repositories for sqltutor and
datasets and tutorials ready.

   $ git clone git://git.savannah.gnu.org/sqltutor.git
   $ git clone git://git.sv.gnu.org/sqltutor/datasets.git

EOF

get_repo "Where is sqltutor git repository? " GIT_SQLTUTOR $GIT_SQLTUTOR
get_repo "Where is datasets git repository? " GIT_DATASETS $GIT_DATASETS

echo
get_word "Sqltutor database name     ? " SQLTUTOR_DATABASE $SQLTUTOR_DATABASE
get_word "Sqltutor WWW  user         ? " SQLTUTOR_WWW_USER $SQLTUTOR_WWW_USER
get_word "Sqltutor WWW  user password? " SQLTUTOR_PASSWORD $SQLTUTOR_PASSWORD
get_word "Sqltutor EXEC user         ? " SQLTUTOR_WWW_EXEC $SQLTUTOR_WWW_EXEC
get_word "Sqltutor EXEC user password? " SQLTUTOR_PASSEXEC $SQLTUTOR_PASSEXEC

echo
get_directory "The directory for installing  CGI  binaries    ? " BINDIR  $BINDIR
get_directory "The directory for installing Info documentation? " INFODIR $INFODIR
postgis


function SqltutorInstaller {

echo
echo Creating/updating database $SQLTUTOR_DATABASE
if psql $SQLTUTOR_DATABASE -c "select ' '" -o /dev/null 2>/dev/null; then
    dropdb $SQLTUTOR_DATABASE
fi
createdb $SQLTUTOR_DATABASE

# In PostgreSQL 9.0 and later, PL/pgSQL is pre-installed by default.
# createlang plpgsql $SQLTUTOR_DATABASE

echo
(cd /tmp && create_user $SQLTUTOR_WWW_USER $SQLTUTOR_PASSWORD )
(cd /tmp && create_user $SQLTUTOR_WWW_EXEC $SQLTUTOR_PASSEXEC )
sleep 12

if [ "x$POSTGIS" != "x" ]; then
    echo
    echo Creating geometry type for PostGIS ...
    sudo -u postgres psql -d $SQLTUTOR_DATABASE -f $POSTGIS_PATH/postgis.sql
    sudo -u postgres psql -d $SQLTUTOR_DATABASE -c "ALTER TABLE geometry_columns  OWNER TO $(whoami);"
    sudo -u postgres psql -d $SQLTUTOR_DATABASE -c "ALTER TABLE geography_columns OWNER TO $(whoami);"
    sudo -u postgres psql -d $SQLTUTOR_DATABASE -c "ALTER TABLE spatial_ref_sys   OWNER TO $(whoami);"
    psql -d $SQLTUTOR_DATABASE -f $POSTGIS_PATH/spatial_ref_sys.sql
fi

preconfigure

echo
echo Running $GIT_SQLTUTOR/configure --bindir=$BINDIR --infodir=$INFODIR
( cd $GIT_SQLTUTOR && ./configure --bindir=$BINDIR --infodir=$INFODIR )
echo
echo Running $GIT_DATASETS/configure --bindir=$BINDIR --infodir=$INFODIR $POSTGIS
( cd $GIT_DATASETS && ./configure --bindir=$BINDIR --infodir=$INFODIR $POSTGIS)


echo
( cd $GIT_SQLTUTOR && make clean install )
( cd $GIT_DATASETS && make clean install )

sudo -u postgres psql -d $SQLTUTOR_DATABASE -c "ANALYZE;"


}

SqltutorInstaller | tee sqltutor-installer.log

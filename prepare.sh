#!/bin/bash

# Example:
#prepare.sh 172.17.0.7 pgsql mydb postgres pass 1000 off

function ERROR() {
        echo "$@"
        exit 1
}

[ -z $7 ] && ERROR "prepare.sh ip driver db user pass size debugmode"

ip=$1
driver=$2
db=$3
user=$4
pass=$5
size=$6
debug=$7

sysbench \
--debug=$debug \
--pgsql-host=$ip \
--db-driver=$driver \
--test=/home/vagrant/sysbench/sysbench/tests/db/oltp.lua \
--pgsql-db=$db --pgsql-user=$user --pgsql-password=$pass \
--oltp-table-size=$size \
prepare


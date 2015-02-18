#!/bin/bash

# Example: 
#./test.sh 172.17.0.7 pgsql mydb postgres pass 1000 1 1000 on off

function ERROR() {
        echo "$@"
        exit 1
}

[ -z $9 ] && ERROR "test.sh ip driver db user pass size threads maxreqs readonly debugmode"

ip=$1
driver=$2 #pgsql|mysql
db=$3
user=$4
pass=$5
size=$6 #tablesize 1000
threads=$7 #1
maxreqs=$8 #1000
readonl=$9 #on|off
debug=$10 #on|off

sysbench \
--debug=$debug \
--db-driver=$driver \
--pgsql-host=$ip --pgsql-user=$user --pgsql-password=$pass --pgsql-db=$db \
--test=/home/vagrant/sysbench/sysbench/tests/db/oltp.lua \
--oltp-test-mode=complex \
--oltp-read-only=$readonl \
--oltp-table-size=$size --num-threads=$threads \
--max-requests=$maxreqs --max-time=0 run

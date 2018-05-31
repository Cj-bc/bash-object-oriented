#!/usr/local/bin/bash
#
# boo -- bash object oriented converter
#
# convert object-oriented file to executable shellscript
# usage: boo <classfile>
#
# copyright (c) 2018 Cj-bc

import standard

# check some settings
[ -d "$BOO_ROOT" ] || error "BOO_ROOT: doesn't exist." && return $EX_OSFILE
[ -f "$1" ] && target=$1 || error "given file doesn't exist" && return $EX_DATAERR

target="$1"
class_name="${1%.*}"


# make some files for  class
# 1. make class dir
# 2. parse codes & separate into method files
# 3. collect fields
# 4. chmod 2.
mkdir -p ${BOO_ROOT}/class/${class_name}


touch "$BOO_ROOT/class/${class_name}/fields"

while read line; do
  if [[ "$line" =~ "def "* ]];then
    line=($line)
    defs=(${defs[@]} ${line[1]})
  fi
done < boss.class.sh

for method_name in "fields" ${defs[@]}; do
  touch ${BOO_ROOT}/class/${class_name}/${method_name}
done


flag=0
while read line; do
  if [ $flag -eq 1 ];then
    if [ "$line" = "end"]

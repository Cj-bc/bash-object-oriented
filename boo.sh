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
# 2. collect method name
# 3. touch files based on 2.
# 4. parse codes
# 5. write methods into files made at 3.
mkdir ${BOO_ROOT}/class/${class_name}

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

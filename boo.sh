#!/usr/local/bin/bash
#
# boo -- bash object oriented converter
#
# convert object-oriented file to executable shellscript
# usage: boo <classfile>
#
# copyright (c) 2018 Cj-bc

import standard
import user:booFunc

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
# 5. convret all codes into traditional shellscript
mkdir -p ${BOO_ROOT}/class/${class_name}


flag=0
while read line; do
  if [ $flag -eq 1 ];then
    [ "$line" =~ ^"end" ] && flag=0 && break
    echo "$line" >> $method_path
  elif [ $flag -eq 0 ] && [[ "$line" =~ "def "* ]]; then
    line=($line)
    method_path="${BOO_ROOT}/class/$class_name}/${line[1]}"
    methods=(${methods[@]} ${line[1]})
    flag=1
  else
    :
  fi
done < $target

flag=0
while read line; do
  [[ "$line" =~ "def "* ]] && flag=0 && break
  [[ "$line" =~ "class "* ]] && flag=1 && continue
  if [ $flag -eq 1 ]; then
    echo "$line" >> ${BOO_ROOT}/class/${class_name}/fields
  fi
done < $target

chmod 744 ${BOO_ROOT}/class/${class_name}/*

for method in ${methods[@]}; do
  boo_convert $method
done

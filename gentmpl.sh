#!/bin/bash

mapName=$1
filename=$2

contents="package ${GOPACKAGE}\n\n// Code generated by gentmpl.sh. DO NOT EDIT.\n\nvar ${mapName} = map[string]string{\n"

for f in ./templates/*.gotxt
do
	f=${f##*/}
	name=${f%.*}
	contents="${contents}\t\"$name\": \`$(cat ./templates/$f)\`,\n"
done

contents="${contents}}\n"

printf "$contents" > "${filename}.go"

gofmt -s -w "${filename}.go"

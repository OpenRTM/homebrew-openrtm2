#!/bin/bash

ls *.gz *.sha256 | awk '{f=$1;sub("sonoma","sequoia");printf("cp %s %s\n",f,$1);}'
ls *sequoia*.sha256 | awk '{printf("sed -i \"\" \"s/sonoma/sequoia/g\" %s\n",$1);}'
ls *.gz *.sha256 | awk '{f=$1;sub("sonoma","ventura");printf("cp %s %s\n",f,$1);}'
ls *ventura*.sha256 | awk '{printf("sed -i \"\" \"s/sonoma/ventura/g\" %s\n",$1);}'

#!/bin/bash
if [ $# -ne 3 ]; then echo "Usage: ip.sh AAA BBB CCC"; echo "Example: use 'ip.sh 192 168 1' to find users in 192.168.1.*";  exit; fi
for i in {0..255}; do ping -c 1 -W 500 $1.$2.$3.$i | grep from > ip.txt; done

#!/bin/bash
echo "* stands for login forbidden"
cat /etc/passwd |cut -f 1,2 -d :

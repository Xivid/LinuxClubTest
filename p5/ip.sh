#!/bin/bash
#uthor by Luweinet@hhstu.edu.cn
    #Using GPL
    #you should change hping path.
    
    netid2=$1

    pin=/sbin/ping
    
    netid=`echo $netid2 |awk -F / '{print $1}'`
    iplist1=/tmp/iplist1
    iplist2=/tmp/iplist2
    iplist3=/tmp/iplist3
    tmp=/tmp/diff
    
    base=`echo $netid | awk -F . '{print $1,$2,$3}'`
    i=`echo $netid |awk -F . '{print $4}'`
    
    all=(${@//[!0-9]/ })
    [ "${#all[@]}" != "8" ] && {
     echo "Usage: "
     echo "${0##*/} ip.ip.ip.ip/mask.mask.mask.mask"
     exit 1
    }
    
    get_addr () {
     if [ "$1" = "-b" ]; then
     op='|'; op1='^'; arg='255'
     shift
     else
     op='&'
     fi
     unset address
     while [ "$5" ]; do
     num=$(( $1 $op ($5 $op1 $arg) ))
     shift
     address="$address.$num"
     done
    }
    
    get_addr -b ${all[@]}
    #broadcast=${address#.}
    bt1=`echo ${address#.} | awk -F . '{print $4}'`
    bt=`expr $bt1 - 1 `
    #loop while bt > $iplist1
     $pin -c 1 -S -d 32 $ip >> $iplist2 #must echo every ping.
     #echo $ip
    done
    
    #if have blank line,means maybe drop by firewall.
    cat $iplist2 | sed -n '/=/p' | awk '{print $2}' | awk -F = '{print $2}' > $iplist3
    echo -ne "`diff $iplist1 $iplist3 > /tmp/diff`"
    
    #cat $tmp | sed -n '/ /p' |awk '{print $2,"	","is NOT alive now"}'
    echo -e "##############################################################
    "
    echo -e "
    "
    echo -ne "!!!This is e result!!!"
    echo -e "
    "
    cat $tmp | sed -n '/ /p' |awk '{print $2,"	","is NOT alive"}'
    echo -e "
    "
    echo -e "##############################################################
    "
    #cat $tmp | sed -n '/^>/p' |awk '{print $2,"	","is alive"}' #in iplist1,which all ip.
    
    rm -rf $iplist1
    rm -rf $iplist2
    rm -rf $iplist3
    rm -rf $tmp

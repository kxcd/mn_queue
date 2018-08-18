#!/bin/bash

# Thanks to Mr. MooCowMoo for this function, a refactoring of my orginal attempt.

mn_queue(){
    dash-cli masternode list full \
        | grep "[^_]ENABLED 70210" \
        | awk -v date="$(date +%s)" '{as=date-$7; mst=(as>$8?as:$8); sep="\t" ; print mst sep date sep $5 sep $7 sep $8 sep as}' \
        | sort -s -k1,1n \
        | awk '{print NR "\t" $0}'
}
mn_queue

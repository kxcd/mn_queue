#!/bin/bash
#set -x

# Create a list of Mastenode details in a tab separated list.  Filtered on ENABLED MNs and Protocol 70210.
# Columns
#  RUN_DATE         UNIX Epoch  (New/Added)
#  OUTPUT           VARCHAR2(67 BYTE),
#  STATUS           VARCHAR2(21 BYTE),
#  PROTOCOL         NUMBER(5),
#  PUBLIC_KEY       VARCHAR2(34 BYTE),
#  LAST_SEEN_TIME   UNIX Epoch
#  ACTIVE_SECONDS   Seconds
#  LAST_PAID_TIME   UNIX Epoch
#  LAST_PAID_BLOCK  NUMBER(6),
#  IP_ADDRESS       VARCHAR2(15 BYTE),
#  PORT             NUMBER(5)
mn_queue(){
	mnlist=$(dash-cli masternode list full|grep "[^_]ENABLED 70210"|awk -v date="$(date +"%s")" '{print date"\t"$5"\t"$7"\t"$8 }')

	# A new variable called ACTIVE_SINCE_TIME = RUN_DATE - ACTIVE_SECONDS needs to be created and added.
	# A new variable is required, the MAX of ACTIVE_SINCE_TIME and LAST_PAID_TIME.

	sorted_mnlist=$(echo "$mnlist"|while read
	do
		active_since=$(echo "$REPLY"|awk -F "\t" '{print $1-$3}')
		last_paid_time=$(echo "$REPLY"|awk -F "\t" '{print $4}')
		max_sincepaid_time=$(( active_since > last_paid_time ? active_since : last_paid_time ))

		# I will now put the max_sincepaid_time up the front so that it can be sorted on.
		echo -e "$max_sincepaid_time\t$REPLY\t$active_since"
	done | sort)

	let i=1
	echo "$sorted_mnlist"|while read
	do
		# Number the list.
		echo -e "$i\t$REPLY"
		((i++))
	done

	unset mnlist sorted_mnlist
}


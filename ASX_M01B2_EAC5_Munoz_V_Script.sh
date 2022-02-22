#!/bin/bash

# Arrays on emmagatzenarem grups etc.
declare -A grups

# Comprovar primer num args OK i informar usuari cas contrari

if [ $# -eq 2 ]; then
	# Fem un append dels grups del fitxer a l'array
	# Default 0, després farem el count

	while read group; do
		grups+=(["$group"]=0)
	done <$1

	# Ara tenim que iterar sobre el directori (parm2)
	# I comptar quantes vegades apareix el grup
	for file in $2*.txt
	do
		# Nested loop per comptar grups
		while read group; do
			if [[ "${!grups[@]}" =~ "${group}" ]]; then
			   ((grups[$group]++))
			fi
			# echo "$group"
		done <$file
	done

	# Print de l'array
	for elm in "${!grups[@]}"
	do
		echo "$elm -> ${grups[$elm]}"
	done

else
	echo "Num parms incorrecte, tenen que ser 2: "
	echo "script.sh fitxer-grups carpeta-users"
fi

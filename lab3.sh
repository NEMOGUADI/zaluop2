#!/usr/bin/env bash
# ПР3. grep, вариант 11
D="$(dirname "$0")/data"; O="$(dirname "$0")/results"; mkdir -p "$O"
echo "== 1. query2, штат MA";            grep "^\([^:]*:\)\{4\}MA:" "$D/query2" | tee "$O/lab3_1.txt"
echo "== 2. query3, два+ нуля в коде";   grep "^[0-9]*00" "$D/query3" | tee "$O/lab3_2.txt"
echo "== 3. query1, фамилия на M, з/п<1000"
grep "^[0-9]\+ \+[A-Z]\+ \+[A-Z] \+M" "$D/query1" | grep " [0-9]\{1,3\}[^0-9]*$" | tee "$O/lab3_3.txt"

#!/usr/bin/env bash
# ПР4. sed / join / ls, вариант 11 (awk не используется)
D="$(dirname "$0")/data"; O="$(dirname "$0")/results"; mkdir -p "$O"; export LC_ALL=C
T=$(mktemp -d); trap 'rm -rf "$T"' EXIT
echo "== Задача 1: последнее слово каждой строки -> в новую строку"
sed 's/^\(.*[^ ]\) \+\([^ ]\+\)$/\1\n\2/' "$D/Hum-Dum.txt" > "$O/lab4_1.txt"; cat "$O/lab4_1.txt"

echo "== Задача 2: товары, заказанные вместе с 'SP JUNIOR RACKET'"
code=$(tr -d '\r' < "$D/query3" | grep 'SP JUNIOR RACKET' | cut -d'!' -f1 | tr -d ' ' | head -n1)
tr -d '\r' < "$D/query5" | sed 's/^ *//; s/ \+/:/g' | cut -d: -f2,3 | sort -t: -k1,1 -k2,2 -u > "$T/t5"
grep ":$code\$" "$T/t5" | cut -d: -f1 | sort -u > "$T/orders"
join -t: -1 1 -2 1 "$T/orders" "$T/t5" | cut -d: -f2 | grep -v "^$code\$" | sort -u > "$T/codes"
tr -d '\r' < "$D/query3" | cut -d'!' -f1,2 | sed 's/ *$//' | sort -t'!' -k1,1 > "$T/t3"
join -t'!' -1 1 -2 1 "$T/codes" "$T/t3" | cut -d'!' -f2 | sort -u | tee "$O/lab4_2.txt"

echo "== Задача 3: подкаталоги STUDENT_DIR с публичными правами r-x (по алфавиту)"
S="${STUDENT_DIR:-/student}"
if [ -d "$S" ]; then
  ls -l "$S" | grep "^d.\{6\}r.x" | tr -s ' ' | cut -d' ' -f9- | sort | tee "$O/lab4_3.txt"
else
  echo "Каталог $S не найден. Запустите так: STUDENT_DIR=/нужный/путь ./lab4.sh"
fi

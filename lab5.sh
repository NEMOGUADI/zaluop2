#!/usr/bin/env bash
# ПР5. awk, вариант 11
D="$(dirname "$0")/data"; O="$(dirname "$0")/results"; mkdir -p "$O"
echo "== Задача 1: последнее слово -> в новую строку"
awk '{ if (NF > 1) { w = $NF; $NF = ""; sub(/[ \t]+$/, ""); print; print w } else print }' "$D/Hum-Dum.txt" > "$O/lab5_1.txt"; cat "$O/lab5_1.txt"
echo "== Задача 2: самая частая зарплата (query1)"
awk '{ s = $NF; gsub(/\r/, "", s); cnt[s]++ }
END { for (k in cnt) if (cnt[k] > m) m = cnt[k]
      for (k in cnt) if (cnt[k] == m) print k, "встречается", m, "раз" }' "$D/query1" | tee "$O/lab5_2.txt"
echo "== Задача 3: фирмы (query3), все товары которых выставлены в один день"
awk -F'!' '{ n = $2; sub(/^ +/, "", n); split(n, w, " "); f = w[1]; sub(/:$/, "", f)
  d = $5; gsub(/[ \r]/, "", d)
  if (!(f in first)) first[f] = d; else if (first[f] != d) diff[f] = 1
  cnt[f]++ }
END { for (f in cnt) if (!(f in diff)) print f, first[f], cnt[f] }' "$D/query3" | sort | tee "$O/lab5_3.txt"

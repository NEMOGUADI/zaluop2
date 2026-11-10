#!/usr/bin/env bash
# ПР2. Файлы, ссылки, символические ссылки (схема варианта 1 – образец, подправьте под рисунок)
SB=$(mktemp -d); cd "$SB" || exit 1
mkdir -p lab2/dirA lab2/dirB/dirC
echo "original file" > lab2/f1.txt
for f in lab2/dirA/f2.txt lab2/dirB/f3.txt lab2/dirB/dirC/f4.txt; do cp lab2/f1.txt $f; sed -i 's/original/copy/' $f; done
ln lab2/f1.txt lab2/dirB/dirC/hard1.txt
ln lab2/dirA/f2.txt lab2/dirB/hard2.txt
ln -s ../../f1.txt lab2/dirB/dirC/sym1.txt
ln -s "$PWD/lab2/dirB/f3.txt" lab2/dirA/sym2.txt
ls -laR lab2
echo "--- доступ по ссылкам"; cat lab2/dirB/dirC/hard1.txt lab2/dirB/dirC/sym1.txt
echo "via hard" >> lab2/dirB/dirC/hard1.txt; cat lab2/f1.txt
echo "--- удаление цели"; rm lab2/f1.txt; ls -la lab2/dirB/dirC; cat lab2/dirB/dirC/hard1.txt
rm lab2/dirB/f3.txt; ls -la lab2/dirA; cat lab2/dirA/sym2.txt || echo "(битая символическая ссылка)"
echo "--- права"; touch work.txt; chmod g+x .; chmod g+rw work.txt; ls -ld . work.txt
# Шаги 9-13 (write/mesg партнёру) выполняются вручную на сервере с партнёром.
for f in lab2/dirB/dirC/hard1.txt lab2/dirB/dirC/sym1.txt lab2/dirA/sym2.txt lab2/dirB/hard2.txt lab2/dirA/f2.txt lab2/dirB/dirC/f4.txt; do unlink "$f"; done
rmdir lab2/dirB/dirC lab2/dirB lab2/dirA lab2
cd /; rm -rf "$SB"

#!/usr/bin/env bash
cd "$(dirname "$0")" || exit 1
for n in 1 2 3 4 5; do echo; echo "################ ПР$n ################"; bash lab$n.sh; done

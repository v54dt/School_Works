#!/usr/local/bin/bash

ls -laR | grep '^-' | sort -k 5 -r -n | head -5 | awk '{NUM=++i;print(NUM,":",$5," ",$9)}' ; ls -lR | grep '^d' |wc -l | awk '{print("Dir num: ",$1)}' ; ls -laR | grep '^-' | wc -l | awk '{print("File num:",$1)}' ; ls -laR | grep '^-' | awk '{ SUM+=$5 } END { print("Total: ",SUM)}'
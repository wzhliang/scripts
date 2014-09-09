#!/bin/sh

pandoc -f markdown -t html $1 | w3m -T text/html

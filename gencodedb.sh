#!/bin/bash

find . -name "*.[ch]" > cscope.files
cscope -b -k
ctags --exclude=build.UML_ATT --exclude=*.js --exclude=*.tex --exclude=*.html -R --fields=+aimnSz --extra=+q --c++-kinds=+p .

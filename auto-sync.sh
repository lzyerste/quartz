#!/bin/bash

rsync -auv --delete --exclude-from='exclude-file.txt' /mnt/d/Nutstore/wiki/ content/wiki

git add .

git commit -m "$(date)"

git push


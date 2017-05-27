#!/bin/bash

git add .
git commit -m "s"
git push
git tag 0.0.5
git push --tag

pod trunk push CHBaseUtil.podspec --allow-warnings


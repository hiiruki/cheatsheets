#!/usr/bin/env bash

(
  echo https://c.hiiruki.dev/
  (
    git ls-files \
      | grep -E '\.md$' \
      | grep -v -E 'CONTRIBUTING|README|Readme' \
      | grep -v -E '^_' \
      | sort \
      | uniq \
      | sed 's/\.md$//g'
  ) \
    | sed 's#^#https://c.hiiruki.dev/#g'
) \
  | xargs curl >/dev/null

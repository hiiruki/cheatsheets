#!/usr/bin/env bash
# Helper to copy the latest cheatsheets to the clipboard for CloudFlare
# purging. This ensures visitors will see new versions.

(
  git log "master@{3 days ago}..HEAD" --pretty="" --name-only \
    | grep -E '\.md$' \
    | grep -v -E 'CONTRIBUTING|README|Readme' \
    | grep -v -E '^_' \
    | sort \
    | uniq \
    | sed 's/\.md$//g'
) \
  | sed 's#^#https://c.hiiruki.dev/#g' \
  | xargs echo https://c.hiiruki.dev/ \
  | pbcopy

echo "Copied to clipboard."
echo "Purge it here:"
echo ""
echo "    https://www.cloudflare.com/a/caching/c.hiiruki.dev"
echo ""
echo "Then click 'Purge Individual Files'"

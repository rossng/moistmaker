#!/usr/bin/env bash
# Cut a vector basemap around Amsterdam West out of the latest Protomaps daily
# OpenStreetMap build. Requires the `pmtiles` CLI (https://github.com/protomaps/go-pmtiles).
set -euo pipefail

OUT="${1:-basemap.pmtiles}"
BBOX="4.39,52.10,5.28,52.64" # ~30 km around Amsterdam West; keep in sync with BASEMAP_BOUNDS in index.html
MAXZOOM=14

for days_ago in 0 1 2 3 4 5 6 7; do
  day=$(date -u -d "-${days_ago} days" +%Y%m%d 2>/dev/null || date -u -v-"${days_ago}"d +%Y%m%d)
  url="https://build.protomaps.com/${day}.pmtiles"
  if curl -sfI "$url" > /dev/null; then
    echo "Extracting from $url"
    pmtiles extract "$url" "$OUT" --bbox="$BBOX" --maxzoom="$MAXZOOM"
    exit 0
  fi
done

echo "No Protomaps build found in the last week" >&2
exit 1

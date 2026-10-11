# moistmaker

Live KNMI precipitation radar around Amsterdam West, as a static GitHub Pages site.

- Radar: raw rain rates (mm/h) from KNMI's public [ADAGUC](https://geoservices.knmi.nl/) WCS, coloured in the browser with matplotlib colour maps.
- Basemap: a vector extract of OpenStreetMap from [Protomaps](https://protomaps.com), cut at build time by `scripts/build-basemap.sh` and served as `basemap.pmtiles`.

## Local development

```sh
brew install pmtiles
scripts/build-basemap.sh      # writes basemap.pmtiles (~65 MB, gitignored)
node scripts/serve.js         # http://localhost:8080 (needs HTTP Range support, so not python -m http.server)
```

## Deployment

`.github/workflows/pages.yml` builds the basemap (cached per month), and deploys `index.html` + `basemap.pmtiles` to GitHub Pages on every push to `main` and monthly.

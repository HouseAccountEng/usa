# Changelog

All notable changes to this project will be documented in this file.

For more information about changelogs, check [Keep a Changelog](http://keepachangelog.com) and
[Vandamme](http://tech-angels.github.io/vandamme).

## [Unreleased]

* [Feature] `google_place_id` filled for every state and ZIP, and for the twenty counties that
  were blank: 50 of 51 states, 3,142 of 3,144 counties and 40,818 of 40,977 ZIPs, each the ID of
  a place of the row's own kind, asked of the Geocoding API by component rather than by address
  -- a state by its name and then its code, a county by its name and state, a ZIP by its code.
  What stays blank is what Google has no such place for: the District of Columbia, Broomfield
  County and Wrangell, which it keeps as cities, and 159 ZIPs it folds into a neighbor's. Cities
  wait for a run of their own. `bin/geocode` is what fills a file, eight requests at a time,
  taking only an answer of the right kind and logging the rest

## 0.1.0 - 2026-09-14

* [Feature] `USA::State`, `USA::County` and `USA::ZIP`, on `usa_states`, `usa_counties` and
  `usa_zips`: the three tables three apps were each keeping, each with a CSV and a backfill of
  its own. A state has a code, a FIPS and a name; a county a FIPS, a name and a state; a ZIP a
  code, the city it is addressed as, a time zone named as Rails names one, and one county
* [Feature] `USA::City` on `usa_cities`, and `USA::CityCounty` on `usa_city_counties`: a city
  belongs to one state and lies in one or more counties, so `city.counties` and `county.cities`
  both answer. The place FIPS is unique within a state rather than nationally, which is what the
  index says
* [Feature] `google_place_id` on all four, filled for every county and blank elsewhere until a
  release fills it -- which is a reason `db:usa:seed` exists
* [Feature] `bin/rails g usa:install`, which copies the six migrations into the host under
  timestamps of its own, and writes nothing else: there is nothing here to configure
* [Feature] `USA.seed`, and a `seed` on each model: every write is an upsert keyed on the code
  or the FIPS, so a second run inserts what is missing, leaves the id of every row a host
  already had, and does not touch the `updated_at` of a row that did not change
* [Feature] `bin/rails db:usa:seed`, which is how a database made from `db/schema.rb` gets its
  rows -- a dump carries none -- and how one catches up with a release that added some
* [Feature] `usa_states.counties_count` and `usa_counties.zips_count`, counted from the rows
  after a seed, since an upsert runs no callback, and only where the count moved
* [Feature] The acronyms `USA`, `ZIP` and `FIPS`, registered before the engine loads, so
  `USA::ZIP` is the class, `usa_zips` the table and 'ZIP' the heading
* [Feature] A load hook per model -- `ActiveSupport.on_load(:usa_zip) { ... }` -- and
  `:usa_record`, where a host says how these tables connect

The data is the current Census vintage: the counties include Connecticut's nine planning
regions and Alaska's current census areas, and the places come from the 2025 Gazetteer rather
than the 2010 list one of the three apps was still carrying.

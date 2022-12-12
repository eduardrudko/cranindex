# cranindex

Small app for indexing packages at CRAN.

Application based on rack, sinatra, rake, activerecord
## Requirements
Ruby: 2.6.4

```shell
brew install rbenv
rbenv init

# list all available versions:
rbenv install -l
rbenv install 2.6.4
cd project_folder
rbenv local 2.6.9
```
Sqlite3 client

```shell
brew install sqlite3
```

## Install
```shell
git clone https://github.com/eduardrudko/cranindex.git
cd cranindex
```
Make sure for the given ruby version gems are installed
```shell
gem install bundler
bundle install
```

Setup db

```shell
rake db:create db:migrate
```
## Usage

#### Notes: 
- Depends on how your I/O fast you may want decrease thread pool in `Rakefile`:
- Be kind to throughput of cran.r-project.org capabilities

`WORKERS_POOL_SIZE = 50 # Should not exceed size of the ActiveRecord connections pool defined at db/config.yml`

Tested on MacbookPro13 2020 `macOS Monterey v12.1` with the thread pool = `50`

Run: 
```shell
rake index:cran:perform
```

Dump packages into csv file:

```shell
cd cranindex
sqlite3 development.db

sqlite> .headers on
sqlite> .mode csv
sqlite> .output packages.csv
sqlite> select * from packages;
```

To view report you can use any free csv reader e.g.: https://limonte.github.io/csv-viewer-online

## Pending improvements:

1. Mock cran resource to reduce dependency during testing
2. Add debug logs
3. Store logs in file
4. Use JRuby interpretator to be CPU bound rather than I/O bound
5. Load tests
6. Summary with succeed and failed threads
7. Prettier look of report
8. Spin up workers rather that shoot
9. Upsert in batches

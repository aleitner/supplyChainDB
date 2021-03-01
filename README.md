# Zenport V2 Models

Plan for running zenport in a single postgres database

## Dependencies

* Docker 

## Makefile

* download-postgres - Download latest postgres image
* postgres - Run postgres container
* createdb - Create zenport db on postgres container
* dropdb - Drop zenport db from postgres container
* migrateup - Run zenport db migrations
* migratedown - Undo zenport db migrations
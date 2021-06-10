# Supply Chain Management Models

Plan for a supply chain management database

## Dependencies

* Docker

## Makefile

* download-postgres - Download latest postgres image
* postgres - Run postgres container
* createdb - Create db on postgres container
* dropdb - Drop db from postgres container
* migrateup - Run db migrations
* migratedown - Undo db migrations

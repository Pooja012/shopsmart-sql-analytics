#!/bin/bash
set -e
rm -f shopsmart.db
sqlite3 shopsmart.db ".read sql/01_schema.sql"
sqlite3 -bail shopsmart.db ".read sql/02_seed_data.sql"
sqlite3 shopsmart.db ".read sql/07_views_indexes.sql"
echo "Database rebuilt."

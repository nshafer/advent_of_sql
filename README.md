# Advent of SQL

My efforts during the Advent of SQL, both applied to SQL, but also Ecto and LiveBook.

Source: https://databaseschool.com/series/advent-of-sql

## Setup

Create a local postgres database.

    $ createdb advent_of_sql_2025

## Daily Challenge

- Create day directory: `mkdir dayN`
- Download the inserts SQL file
- Insert data: `psql advent_of_sql_2025 -f dayN-inserts.sql`
- Create daily SQL file "dayN.sql"
- Solve challenge using SQL using e.g. `psql` or DataGrip (my choice)
- Copy previous day's `dayN.livemd`
- Edit with `livebook server dayN.livemd`
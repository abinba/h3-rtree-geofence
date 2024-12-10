#!/bin/bash

set -e

export PGUSER=postgres
export PGDATABASE=h3_test
export PGPASSWORD=postgres
export PGHOST=localhost

CLIENTS=(10 30 60)
DURATION=(30 60)

for clients in "${CLIENTS[@]}"; do
  for duration in "${DURATION[@]}"; do
    echo "Testing with $clients clients and duration $duration"

    echo "PostGIS test:"
    pgbench -h localhost \
      -f postgis_test.sql \
      -c $clients -j 4 -T $duration \
      -P 3 \
      --log --sampling-rate=1 \
      > ./results/results_postgis_c${clients}_d${duration}.log 2>&1

    echo "H3 test:"
    pgbench -h localhost \
      -f h3_test.sql \
      -c $clients -j 4 -T $duration \
      -P 3 \
      --log --sampling-rate=1 \
      > "./results/results_h3_c${clients}_d${duration}.log" 2>&1
  done
done


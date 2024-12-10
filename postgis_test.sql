\set lon random_gaussian(17028, 17045, 2.5)
\set lat random_gaussian(51105, 51114, 2.5)

SELECT
    id
FROM
    sights
WHERE
    ST_Contains(geom, ST_SetSRID(ST_Point(:lon::float/1000, :lat::float/1000), 4326));
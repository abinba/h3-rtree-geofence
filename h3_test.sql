\set lon random_gaussian(17028, 17045, 2.5)
\set lat random_gaussian(51105, 51114, 2.5)

SELECT
    r.sight_id
FROM
    reverse_h3 r
WHERE
    h3_lat_lng_to_cell(ST_SetSRID(ST_Point(:lon::float/1000, :lat::float/1000), 4326), 12)::text = r.h3_hash;
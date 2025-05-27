-- old school band
-- list 'glam rock' 
SELECT band_name, IF(split is NULL, 2022, split) - formed AS lifespan
    FROM metal_bands
    WHERE style like '%glam rock%'

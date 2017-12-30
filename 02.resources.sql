WITH	tiles (rn, x, y) AS
	(
	VALUES
		(1, 0, 0),
		(2, 1, 0),
		(3, 2, 0),
		(4, 3, 1),
		(5, 4, 2),
		(6, 4, 3),
		(7, 4, 4),
		(8, 3, 4),
		(9, 2, 4),
		(10, 1, 3),
		(11, 0, 2),
		(12, 0, 1),
		(13, 1, 1),
		(14, 2, 1),
		(15, 3, 2),
		(16, 3, 3),
		(17, 2, 3),
		(18, 1, 2),
		(19, 2, 2)
	),
	resources AS
	(
	SELECT	'////####^^^' || CHR(34) || CHR(34) || CHR(34) || CHR(34) || '... '::TEXT tile_resources
	)
SELECT	*
FROM	tiles
JOIN	(
	SELECT	ROW_NUMBER() OVER (ORDER BY RANDOM()) rn,
		resource
	FROM	resources
	CROSS JOIN
		LATERAL
		REGEXP_SPLIT_TO_TABLE(tile_resources, '') q (resource)
	) tr
USING	(rn)



CREATE TABLE t_Patrik_Stoulil_project_SQL_secondary_final AS
SELECT
	e.year,
	e.country,
	e.GDP,
	e.gini,
	e.population
FROM
	countries c
LEFT JOIN economies e 
ON
	c.country = e.country
WHERE
	continent = 'Europe'
	AND year BETWEEN 2006 AND 2018
GROUP BY
	e.`year`,
	e.country
ORDER BY
	country,
	year



SELECT x.name_of_commodity, avg(year_change) AS average_price_development FROM
(
SELECT
	tps.payroll_year,
	tps.name_of_commodity,
	tps.price_of_commodity,
	tps2.payroll_year AS previous_year,
	tps2.price_of_commodity AS previous_year_price_of_comodity,
	(tps.price_of_commodity - tps2.price_of_commodity)/tps2.price_of_commodity * 100 AS year_change
FROM
	t_Patrik_Stoulil_project_SQL_primary_final tps
JOIN t_Patrik_Stoulil_project_SQL_primary_final tps2 
ON
	tps.payroll_year = tps2.payroll_year + 1
	AND tps.name_of_commodity = tps2.name_of_commodity
WHERE
	tps.name_of_commodity IS NOT NULL
	and tps.price_of_commodity IS NOT NULL
GROUP BY tps.payroll_year, tps.name_of_commodity 
ORDER BY tps.name_of_commodity, tps.payroll_year) x
GROUP BY x.name_of_commodity
ORDER BY avg(year_change)
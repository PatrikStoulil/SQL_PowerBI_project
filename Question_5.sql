
SELECT
	*,
	CASE
		WHEN salary_year_change > 5
		OR commodities_price_year_change > 5
		OR following_year_salary_change > 5
		OR following_year_commodities_price_change > 5 THEN 1
		ELSE 0
	END AS GDP_influence
FROM (
WITH salary_and_comodities_year_change AS (
	SELECT
		a.payroll_year,
		salary_year_Change,
		commodities_price_year_change
	FROM
		(
		SELECT
			payroll_year,
			round(avg(salary), 2) AS avg_salary,
			round(lag(avg(salary)) OVER (ORDER by payroll_year), 2) AS previous_year_avg_salary,
			round((round(avg(salary), 2) - round(lag(avg(salary)) OVER (ORDER by payroll_year), 2) ) / round(avg(salary), 2) * 100, 2) as salary_year_change
		FROM
			t_Patrik_Stoulil_project_SQL_primary_final tpspspf
		GROUP BY
			payroll_year) a
	JOIN(
		SELECT
			payroll_year ,
			round(avg(price_of_commodity), 2) AS avg_price_of_commodity,
			round(lag(avg(price_of_commodity)) OVER (ORDER BY payroll_year), 2) AS previous_year_avg_oommodity_price,
			round((round(avg(price_of_commodity), 2) - round(lag(avg(price_of_commodity)) OVER (ORDER BY payroll_year), 2)) / round(avg(price_of_commodity), 2) * 100, 2) as commodities_price_year_change
		FROM
			t_Patrik_Stoulil_project_SQL_primary_final tpspspf
		GROUP BY
			payroll_year) b
	WHERE
		a.payroll_year = b.payroll_year)
SELECT
		tps1.year,
		tps1.GDP,
		tps2.year as previous_year,
		tps2.GDP as previous_year_GDP,
		round((tps1.GDP-tps2.GDP)/ tps2.GDP * 100,2) as GDP_growth,
		sacyc.salary_year_Change,
		sacyc.commodities_price_year_change,
		sacyc2.payroll_year as following_year,
		sacyc2.salary_year_Change as following_year_salary_change,
		sacyc2.commodities_price_year_change as following_year_commodities_price_change
	FROM
		t_Patrik_Stoulil_project_SQL_secondary_final tps1
	LEFT JOIN t_Patrik_Stoulil_project_SQL_secondary_final tps2
ON
		tps1.`year` = tps2.`year` + 1
		AND tps1.country = tps2.country
	LEFT JOIN salary_and_comodities_year_change sacyc
ON
		tps1.`year` = sacyc.payroll_year
	LEFT JOIN salary_and_comodities_year_change sacyc2
ON
		tps1.`year` = sacyc2.payroll_year - 1
	WHERE
		tps1.country = 'Czech Republic') x
WHERE
	GDP_growth > 5
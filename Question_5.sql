

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

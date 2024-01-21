


SELECT
	payroll_year,
	industry_name,
	salary
FROM
	t_Patrik_Stoulil_project_SQL_primary_final tpspspf
WHERE
	payroll_year IN (2006, 2018)
GROUP BY
	industry_name,
	payroll_year
	
	

	
SELECT
	*
FROM
	(
	SELECT
		payroll_year,
		industry_name,
		salary,
		payroll_year - 1 AS previous_year,
		lag(salary) OVER (PARTITION BY industry_name ORDER BY industry_name, payroll_year) AS previous_year_salary
	FROM
		t_Patrik_Stoulil_project_SQL_primary_final tpspspf
	GROUP BY
		payroll_year,
		industry_name
	ORDER BY
		industry_name,
		payroll_year) x
WHERE
	previous_year_salary > salary
	
	












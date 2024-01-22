


SELECT
	payroll_year,
	avg(salary) AS average_salary,
	name_of_commodity,
	price_of_commodity,
	round(avg(salary)/ price_of_commodity,2) AS possible_amounth_to_buy
FROM
	t_Patrik_Stoulil_project_SQL_primary_final tpspspf
WHERE
	payroll_year IN (2006, 2018)
	AND name_of_commodity IN ('Chléb konzumní kmínový', 'Mléko polotučné pasterované')
GROUP BY
	payroll_year,
	name_of_commodity,
	price_of_commodity
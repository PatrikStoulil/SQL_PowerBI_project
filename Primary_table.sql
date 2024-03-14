
	CREATE TABLE  t_Patrik_Stoulil_project_SQL_primary_final AS
	WITH salaries AS (
SELECT
	cp.payroll_year,
	cpib.name AS industry_name ,
	round(avg(cp.value),2) AS salary
FROM
	czechia_payroll cp
JOIN czechia_payroll_industry_branch cpib 
ON
	cp.industry_branch_code = cpib.code
WHERE
	value IS NOT NULL
	AND 
	value_type_code = 5958
	AND industry_branch_code IS NOT NULL
GROUP BY
	payroll_year,
	industry_branch_code
ORDER BY
	payroll_year)
,
commodities_prices AS (
SELECT
	year(cp2.date_from) AS year,
	cpc2.name as name_of_commodity,
	round(avg(cp2.value),2) as price_of_commodity
FROM
	czechia_price cp2
JOIN czechia_price_category cpc2 
ON
	cp2.category_code = cpc2.code
GROUP BY year(cp2.date_from), 
	cpc2.name)
SELECT 
		s.payroll_year,
		s.industry_name, 
		s.salary,
		compr.name_of_commodity,
		compr.price_of_commodity
FROM salaries s
JOIN commodities_prices compr
ON s.payroll_year = compr.year
ORDER BY
	payroll_year,
	industry_name,
	name_of_commodity
	
	
	



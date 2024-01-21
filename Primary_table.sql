
CREATE TABLE t_Patrik_Stoulil_project_SQL_primary_final AS
SELECT
	cp.payroll_year,
	cpib.name AS industry_name,
	round(avg(cp.value), 2) AS salary,
	cpc.name AS name_of_commodity,
	round(avg(cp2.value), 2) as price_of_commodity
FROM
	czechia_payroll cp
LEFT JOIN czechia_price cp2 
ON
	cp.payroll_year = year(cp2.date_from)
LEFT JOIN czechia_price_category cpc 
ON
	cp2.category_code = cpc.code
LEFT JOIN czechia_payroll_industry_branch cpib 
ON
	cp.industry_branch_code = cpib.code
WHERE
	value_type_code = 5958
	AND industry_branch_code IS NOT NULL
GROUP BY
	payroll_year ,
	cpib.name ,
	cpc.name
ORDER BY
	payroll_year,
	industry_name,
	name_of_commodity;



DROP TABLE t_Patrik_Stoulil_project_SQL_primary_final



CREATE TABLE t_Patrik_Stoulil_project_SQL_primary_final AS
SELECT
	cp.payroll_year,
	cpib.name AS industry_name,
	round(avg(cp.value), 2) AS salary,
	cpc.name AS name_of_commodity,
	round(avg(cp2.value), 2) as price_of_commodity
FROM
	czechia_payroll cp
JOIN czechia_price cp2 
ON
	cp.payroll_year = year(cp2.date_from)
JOIN czechia_price_category cpc 
ON
	cp2.category_code = cpc.code
JOIN czechia_payroll_industry_branch cpib 
ON
	cp.industry_branch_code = cpib.code
WHERE
	value_type_code = 5958
	AND industry_branch_code IS NOT NULL
GROUP BY
	payroll_year ,
	cpib.name ,
	cpc.name
ORDER BY
	payroll_year,
	industry_name,
	name_of_commodity;

SELECT * FROM t_Patrik_Stoulil_project_SQL_primary_final tpspspf 


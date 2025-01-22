-- UNION - uniq values
-- ALL  - all values

SELECT 
	'Customer' as type
	, EMAIL as customer_email
FROM Customer c 

UNION 

SELECT 
	'Employee' as type
	, EMAIL as employee_email
FROM Employee e 


-- INTERSECT повертає всі значення  в першому запиті,але за умови якщо вони є в другому
-- EXCEPT повертає лише ті записи, які присутні в першому запиті, але відсутні в другому

SELECT 
	'Customer' as type
	, EMAIL as customer_email
FROM Customer c 

EXCEPT  

SELECT 
	'Employee' as type
	, EMAIL as employee_email
FROM Employee e 


-- Запит виконує обчислення мінімальної та максимальної суми з таблиці Invoice та об'єднує їх в один результат
SELECT 
	'min_price' as parameter
	, MIN(total) as value 
FROM Invoice i 

UNION

SELECT 
	'max_price' as parameter
	, MAX(total) as value 
FROM Invoice i 
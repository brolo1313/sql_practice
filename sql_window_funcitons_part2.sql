-- ROW_NUMBER() - Надає унікальний порядковий номер для кожного рядка
-- RANK(): Присвоює однаковий ранг для однакових значень, але пропускає ранги (наприклад, після двох рядків з рангом 1 буде ранг 3)
-- DENSE_RANK(): Присвоює однаковий ранг для однакових значень, але не пропускає ранги (наприклад, після двох рядків з рангом 1 буде ранг 2)
/* PARTITION BY дозволяє розділити дані на групи за певним полем
   ROW_NUMBER() потім присвоює унікальний порядковий номер для кожного рядка в межах кожної групи.
*/
-- OVER() — це ключове слово в SQL, яке використовується разом з аналітичними функціями (такі як ROW_NUMBER(), RANK(), LAG(), SUM() і інші), щоб вказати, як саме потрібно обробляти або групувати дані.(визначає "вікно", над яким застосовується аналітична функція.)

SELECT 
	InvoiceId 
	,
	CustomerId 
	,
	Total
	,
	ROW_NUMBER() 	over(PARTITION BY CustomerID ORDER BY Total DESC) as invoice_number
	,
	RANK() 			over(ORDER BY Total DESC) as invoice_rank
	,
	DENSE_RANK() 	over(ORDER BY Total DESC) as invoice_rank2
FROM
	Invoice i
ORDER BY
	CustomerId
	
-- LAG() дозволяє отримати значення з попереднього рядка в межах груп
-- LEAD() дозволяє отримати значення з наступного рядка в межах груп
-- JULIANDAY() дозволяє обчислити різницю між датами, переведенням їх у кількість днів
	
SELECT 
	InvoiceId 
	, CustomerId 
	, InvoiceDate 
	, Total 
	, LAG(Total, 1) over(PARTITION by CustomerId ORDER BY InvoiceDate) as lag_total
	, LAG(InvoiceDate, 1) over(PARTITION by CustomerId ORDER BY InvoiceDate) as lag_date
	, JULIANDAY(InvoiceDate) - JULIANDAY(LAG(InvoiceDate, 1) over(PARTITION by CustomerId ORDER BY InvoiceDate)) as diff_in_days
	, LEAD(Total, 1) over(PARTITION by CustomerId ORDER BY InvoiceDate) as lead_total
FROM Invoice i  
ORDER BY CustomerId 


-- FIRST_VALUE() дозволяє отримати значення з першого рядка в межах групи
-- LAST_VALUE()  дозволяє отримати значення з останнього рядка в межах групи
-- ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING: Ця частина коду вказує, що вікно має охоплювати всі рядки

SELECT 
	 InvoiceId 
	 , CustomerId 
	 , InvoiceDate 
	 , Total 
--	 , FIRST_VALUE(Total) over(PARTITION by CustomerId order by InvoiceDate) as first_amount
	 ,  LAST_VALUE(Total) OVER (PARTITION BY CustomerId ORDER BY InvoiceDate 
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_amount
FROM Invoice i 


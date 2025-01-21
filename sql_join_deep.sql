select * 
from Invoice i LIMIT 50;

SELECT * FROM InvoiceLine il limit 50;
SELECT * FROM Track t limit 10;
SELECT * FROM Album a limit 10;
SELECT * FROM Artist art limit 10;

-- JOIN between tables
SELECT 
	t.TrackId 
	, t.Name 
	, a.AlbumId 
	, a.ArtistId
	, art.Name 
FROM Track t 
JOIN Album a ON t.AlbumId = a.AlbumId 
JOIN Artist art ON a.ArtistId = art.ArtistId 
WHERE art.Name LIKE "B%"
LIMIT 10;


SELECT 
	art.Name 
	, COUNT(t.TrackId) 
FROM Track t 
JOIN Album a ON t.AlbumId = a.AlbumId 
JOIN Artist art ON a.ArtistId = art.ArtistId 
WHERE art.Name LIKE "B%"
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;


-- INNER, LEFT, RIGHT, FULL, CROSS, SELF - JOIN

-- INNER JOIN вибирає записи, які мають відповідні значення в обох таблицях.
-- LEFT/RIGHT JOIN повертає всі записи з LEFT/RIGHT таблиці
-- FULL OUTER JOIN повертає всі записи, якщо є відповідність у лівих (table1) або правих (table2) записах таблиці.
-- SELF Самооб’єднання є звичайним об’єднанням, але таблиця об’єднується сама з собою.
-- CROSS Всі можливі комібнації(no matching)


SELECT 
	i.InvoiceId 
FROM Invoice i 
LEFT JOIN Customer c ON i.CustomerId = c.CustomerId 
WHERE c.CustomerId IS NULL;


SELECT 
	i.InvoiceId
	, i.CustomerId 
	, c.CustomerId 
	, c.FirstName 
FROM Invoice i 
LEFT JOIN Customer c ON i.CustomerId = c.CustomerId 
-- WHERE c.FirstName LIKE  ("N%")
LIMIT 10;

SELECT 
	i.InvoiceId
	, i.CustomerId 
	, c.CustomerId 
	, c.FirstName 
FROM Invoice i 
LEFT JOIN Customer c ON i.CustomerId = c.CustomerId 
ORDER BY 1
LIMIT 10;


SELECT 
	c.City
FROM Customer c 
WHERE c.City  LIKE  ("Ber%")


-- Цей запит знаходить пари покупців, які живуть в одному місті, та виводить їхні імена, місто та ідентифікатори.
SELECT 
	c.FirstName AS Customer_Name_1
	, b.FirstName AS Customer_Name_2
	, c.City
	, c.CustomerID
FROM 
	Customer c 
	, Customer b
WHERE c.CustomerID <> b.CustomerID
AND c.City = b.City
AND c.CustomerID < b.CustomerID 
ORDER BY 3;



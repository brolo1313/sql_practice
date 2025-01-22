-- practice

SELECT *
FROM Customer c 
LIMIT 10;


/*Запит виводить ідентифікатор, ім'я та прізвище клієнтів, 
які мають принаймні три різних жанри серед усіх треків, які вони придбали, разом із кількістю різних жанрів для кожного клієнта.
*/
-- WITH CTE — Common Table Expression
WITH melomaniacs AS (

	SELECT 
		c.CustomerId 
		, c.FirstName 
		, c.LastName 
		, COUNT(DISTINCT g.GenreId) As nmb_genres
	FROM InvoiceLine il 
	LEFT JOIN Track t ON il.TrackId = t.TrackId 
	LEFT JOIN Genre g ON t.GenreId = g.GenreId 
	LEFT JOIN Invoice i ON il.InvoiceId = i.InvoiceId 
	LEFT JOIN Customer c ON i.CustomerId = c.CustomerId 
	GROUP BY 1,2,3
	HAVING COUNT(DISTINCT g.GenreId) >= 3
)

, invoices AS (

	SELECT *
	FROM Invoice i 
	WHERE InvoiceDate BETWEEN '2009-01-01' AND '2010-01-01' AND i.InvoiceId 
)

SELECT *
FROM melomaniacs m
--WHERE m.CustomerId IN (SELECT CustomerId FROM invoices)
LEFT JOIN invoices i ON m.CustomerId = i.CustomerId
--WHERE i.CustomerId IS NOT NULL AND i.BillingState IS NOT NULL 

	
-- Вивести кількість рахунків для кожного клієнта
SELECT *
FROM Invoice i
ORDER BY i.CustomerId 

SELECT  COUNT(*) as all_invoices
FROM Invoice i

SELECT 
	i.CustomerId 
	,
	c.FirstName
	,
	c.LastName
	,
	COUNT(i.CustomerId) As nmb_of_invoices
FROM
	Invoice i
LEFT JOIN Customer c ON
	i.CustomerId = c.CustomerId
GROUP BY 1


-- вивести всі оплачені треки в алфавітному порядку AC/DC і їх кількість
-- all payed tracks 2240

SELECT COUNT(il.TrackId) as poyed_tracks
FROM InvoiceLine il 

SELECT COUNT(*)
FROM Track t 

SELECT *
FROM InvoiceLine il
--ORDER BY il.TrackId
--WHERE il.TrackId = 2

SELECT 
    il.TrackId,
    t.Name,
    t.Composer,
    COUNT(il.TrackId) AS nmb_payed_track,
    t.UnitPrice,
    COUNT(il.TrackId) * t.UnitPrice AS money_recieved
FROM InvoiceLine il
LEFT JOIN Track t ON il.TrackId = t.TrackId
WHERE t.Composer LIKE "AC/DC"
GROUP BY 1, 2, 3, 5
ORDER BY 2;


-- розбити треки по жанрам і вивести їх кількість на кожен жанр

SELECT
	g.Name as genre_name
    ,
	COUNT(t.GenreId) as tracks_in_genre
FROM
	Track t
JOIN 
    Genre g ON
	t.GenreId = g.GenreId
GROUP BY
	t.GenreId
ORDER BY
	g.Name

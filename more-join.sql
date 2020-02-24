-- More JOIN operations

-- List the films where the yr is 1962 [Show id, title] 

SELECT id, title
 FROM movie
 WHERE yr=1962

-- Give year of 'Citizen Kane'. 

SELECT yr FROM movie WHERE title = 'Citizen Kane'

-- List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). 
-- Order results by year. 

SELECT id, title, yr 
FROM movie
WHERE title like '%Star Trek%'
ORDER BY yr

-- What id number does the actor 'Glenn Close' have? 

SELECT id FROM actor WHERE name = 'Glenn Close'

-- What is the id of the film 'Casablanca' 

SELECT id FROM movie WHERE title = 'Casablanca'

-- Obtain the cast list for 'Casablanca'. 

SELECT name 
FROM casting JOIN actor on actorid = id
WHERE movieid = (SELECT id FROM movie WHERE title = 'Casablanca')

-- Obtain the cast list for the film 'Alien' 

SELECT name 
FROM casting JOIN actor on actorid = id
WHERE movieid = (SELECT id FROM movie WHERE title = 'Alien')

-- List the films in which 'Harrison Ford' has appeared 

SELECT title
FROM casting JOIN movie ON movieid = id
WHERE actorid = (SELECT id FROM actor WHERE name = 'Harrison Ford')

-- List the films where 'Harrison Ford' has appeared - but not in the starring role. 
-- [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role] 

SELECT title
FROM casting JOIN movie ON movieid = id
WHERE actorid = (SELECT id FROM actor WHERE name = 'Harrison Ford') AND ord <> 1

-- List the films together with the leading star for all 1962 films. 

SELECT title, name
FROM (casting JOIN movie on movieid = movie.id) JOIN actor on actorid = actor.id
WHERE ord = 1 and yr = 1962

-- Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies. 

SELECT yr, COUNT(title) FROM 
movie JOIN casting on movie.id = movieid
JOIN actor ON actorid = actor.id
WHERE name = 'Rock Hudson'
GROUP BY yr
HAVING COUNT(title)>2

-- List the film title and the leading actor for all of the films 'Julie Andrews' played in. 

SELECT DISTINCT title, name
FROM movie JOIN casting on movie.id = movieid
JOIN actor on actorid = actor.id
WHERE ord = 1 and movieid in ( SELECT movieid FROM casting
WHERE actorid IN (
  SELECT id FROM actor
  WHERE name='Julie Andrews'))

-- Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles. 

SELECT name
FROM casting JOIN actor on actorid = id
WHERE ord = 1
GROUP BY name
HAVING COUNT(movieid) >= 15
ORDER BY name

-- List the films released in the year 1978 ordered by the number of actors in the cast, then by title. 

SELECT title, COUNT(actorid)
FROM movie JOIN casting ON id = movieid
WHERE yr = 1978
GROUP BY movieid
ORDER BY COUNT(actorid) DESC, title

-- List all the people who have worked with 'Art Garfunkel'. 

SELECT DISTINCT name
FROM movie JOIN casting ON movie.id = movieid
JOIN actor on actorid = actor.id
WHERE movieid in (SELECT movieid FROM casting JOIN actor ON actorid = actor.id WHERE name = 'Art Garfunkel') and actor.name <> 'Art Garfunkel'
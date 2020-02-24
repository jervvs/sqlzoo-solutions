-- Nobel Prizes: Aggregate functions

-- Show the total number of prizes awarded. 

SELECT COUNT(winner) FROM nobel

-- List each subject - just once 

SELECT DISTINCT subject FROM nobel

-- Show the total number of prizes awarded for Physics. 

SELECT COUNT(winner) FROM nobel WHERE subject = 'Physics'

-- For each subject show the subject and the number of prizes. 

SELECT subject, COUNT(winner) FROM nobel GROUP BY subject

-- For each subject show the first year that the prize was awarded. 

SELECT subject, MIN(yr) FROM nobel GROUP BY subject

-- For each subject show the number of prizes awarded in the year 2000. 

SELECT subject, COUNT(winner) FROM nobel WHERE yr = 2000 GROUP BY subject

-- Show the number of different winners for each subject. 

SELECT subject, COUNT(DISTINCT winner) FROM nobel GROUP BY subject

-- For each subject show how many years have had prizes awarded. 

SELECT subject, COUNT(DISTINCT yr) FROM nobel GROUP BY subject

-- Show the years in which three prizes were given for Physics. 

SELECT yr FROM nobel WHERE subject = 'Physics' GROUP BY yr HAVING COUNT(yr) = 3

-- Show winners who have won more than once. 

SELECT winner FROM nobel GROUP BY winner HAVING COUNT(winner) >1 

-- Show winners who have won more than one subject. 

SELECT winner FROM nobel GROUP BY winner HAVING COUNT(DISTINCT subject) > 1

-- Show the year and subject where 3 prizes were given. Show only years 2000 onwards. 

SELECT yr, subject FROM nobel WHERE yr >= 2000 GROUP BY yr, subject HAVING COUNT(winner) = 3
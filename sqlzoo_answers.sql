-- 0 SELECT basics
-- 1.
SELECT population FROM world
  WHERE name = 'Germany'
-- 2.
SELECT name, population FROM world
  WHERE name IN ('Sweden', 'Norway', 'Denmark');

-- 3.
SELECT name, area FROM world
  WHERE area BETWEEN 200000 AND 250000
-- 1 SELECT name

-- 1.
SELECT name FROM world
  WHERE name LIKE 'Y%'
-- 2.
SELECT name FROM world
  WHERE name LIKE '%y'
-- 3.
SELECT name FROM world
WHERE name LIKE '%x%'
-- 4.
SELECT name FROM world
WHERE name LIKE '%land'
-- 5.
SELECT name FROM world
  WHERE name LIKE 'C%' AND name LIKE '%ia'
-- 6.
SELECT name FROM world
  WHERE name LIKE '%oo%'
-- 7.
SELECT name FROM world
  WHERE name LIKE '%A%A%A%'
-- 8.
SELECT name FROM world
 WHERE name LIKE '_t%'
ORDER BY name
-- 9.
SELECT name FROM world
 WHERE name LIKE '%o__o%'
-- 10.
SELECT name FROM world
 WHERE name LIKE '____'
-- 11.
SELECT name
  FROM world
 WHERE name=capital
-- 12.
SELECT name 
  FROM world
 WHERE capital = concat(name, ' city')
-- 13, 
SELECT capital, name
FROM world
WHERE capital LIKE concat('%',name,'%')
14, and 15 have a bug, please skip them


-- 2 SELECT from World
-- 1.
SELECT name, continent, population FROM world
-- 2.
SELECT name FROM world
WHERE population > 200000000
-- 3.
SELECT name, gdp/population
FROM world
WHERE population > 200000000
-- 4.
SELECT name, population/1000000
FROM world
WHERE continent ='South America'
-- 5.
SELECT name, population
FROM world
WHERE name IN ('France','Germany','Italy')
-- 6.
SELECT name 
FROM world
WHERE name LIKE 'United%'
-- 7.
SELECT name, population, area
FROM world
WHERE area >3000000 OR population > 250000000

-- 8.
SELECT name, population, area
FROM world
WHERE population > 250000000 OR area > 3000000
EXCEPT 
SELECT name, population, area 
FROM world
WHERE population > 250000000 AND area > 3000000
-- 9.
SELECT name, ROUND(population, -4)/1000000, ROUND(GDP, -7)/1000000000
FROM world
WHERE continent = 'South America'
-- 10.
SELECT name, ROUND(gdp/population, -3)
FROM world 
WHERE gdp > 1000000000000
-- 11.
SELECT name,       
       capital
 FROM world
 WHERE LENGTH(name)=LENGTH(capital)
-- 12.
SELECT name, capital
FROM world
WHERE  LEFT(name,1)= LEFT(capital,1)
AND capital != name
-- 13.
SELECT name
   FROM world

WHERE name LIKE '%A%' AND 
 name LIKE '%I%' AND 
 name LIKE '%U%' AND 
 name LIKE '%E%' AND 
name LIKE '%O%' AND 
 name NOT LIKE '% %'


-- 3 SELECT from Nobel
-- 1.
SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950
-- 2.
SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature'
-- 3.
SELECT yr, subject 
FROM nobel
WHERE winner = 'Albert Einstein'
-- 4.

SELECT winner
FROM nobel
WHERE subject = 'Peace' AND yr > 1999
-- 5.
SELECT yr, subject, winner 
FROM nobel
WHERE subject='literature' AND yr > 1979 AND yr <1990
-- 6.
SELECT * FROM nobel
WHERE winner IN ('Theodore Roosevelt',
            'Woodrow Wilson',
            'Jimmy Carter',
            'Barack Obama')
-- 7.
SELECT winner FROM nobel
WHERE winner LIKE 'John%'
-- 8.
SELECT yr, subject, winner 
FROM nobel
WHERE subject = 'Physics' AND yr = '1980' OR
subject = 'Chemistry' AND yr = '1984'
-- 9.
SELECT yr, subject, winner 
FROM nobel WHERE subject !='Chemistry' AND subject !='Medicine' AND yr='1980'
-- 10.
SELECT yr, subject, winner 
FROM nobel WHERE
yr <1910 AND 
subject = 'medicine' OR
yr > 2003 AND
subject = 'Literature'

-- 11.
SELECT * FROM nobel
WHERE winner = 'PETER GRÜNBERG'
-- 12.
SELECT * FROM nobel
WHERE winner LIKE '%neill'
-- 13.
SELECT winner ,yr, subject FROM nobel
WHERE winner LIKE 'Sir%'
ORDER BY yr DESC 

-- 14.
SELECT winner, subject
 FROM nobel
 WHERE yr=1984
 ORDER BY subject IN ('Physics','Chemistry'), subject, winner 


-- 4 SELECT within SELECT
-- 1.
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')
-- 2.
SELECT name FROM world
  WHERE gdp/population >
     (SELECT gdp/population FROM world
      WHERE name ='United Kingdom')
       AND continent='Europe'
-- 3.
SELECT name, continent
FROM world
WHERE continent = (
  SELECT continent 
    FROM world 
      WHERE name ='Australia')
        OR continent= (
          SELECT continent 
            FROM world 
              WHERE name ='Argentina')
ORDER BY name ASC
-- 4.
SELECT name, population 
FROM world
WHERE population >
  (SELECT population
   FROM world
   WHERE name = 'Canada')
      AND population <
  (SELECT population
   FROM world
   WHERE name = 'Poland')
-- 5.
SELECT name, CONCAT
(ROUND(
100*population/(
SELECT population
FROM world
WHERE name ='Germany'
)
)
, '%')
FROM world
WHERE continent ='Europe'

-- As noted in the tutorial, questions 6 - 10 in this unit are considered bonuses, just like units 6 - 8+
-- 6.
SELECT name
FROM world
WHERE gdp >(
  SELECT MAX(gdp) 
   FROM world 
    WHERE continent = 'Europe' )
-- 7.
SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area>0)
-- 8.
SELECT Continent, MIN(Name) 
FROM world
GROUP BY continent;
-- 9.
SELECT name, continent, population 
FROM world x
WHERE population <= 25000000
AND (SELECT MAX(population) FROM world y
        WHERE y.continent=x.continent)
          <= 25000000
-- 10.
SELECT name, continent
FROM world x
WHERE population > (SELECT population FROM world y
WHERE y.continent=x.continent 
ORDER BY population DESC
LIMIT 1
OFFSET 1
)*3


-- 5 SUM and COUNT
-- 1.
SELECT SUM(population)
FROM world
-- 2.
SELECT continent
FROM world
GROUP BY continents
-- 3.
SELECT SUM(gdp)
FROM world
WHERE continent = 'Africa'
-- 4.
SELECT COUNT(name)
FROM world
WHERE area >= 1000000
-- 5.
SELECT SUM(population)
FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania')
-- 6.
SELECT continent, ( SELECT COUNT(name)
FROM world y
WHERE x.continent = y.continent ) FROM world x
GROUP BY continent
-- 7.
SELECT continent, ( SELECT COUNT(name)
FROM world y
WHERE x.continent = y.continent 
AND population > 10000000) FROM world x
GROUP BY continent
-- 8.
SELECT continent FROM world x
WHERE ( SELECT SUM(population)
FROM world y
WHERE x.continent = y.continent ) > 100000000
GROUP BY continent

-- Note: the units below this are bonus for this weekend, and they will be required in a future assignment. If you do them now you will be ahead of the game!
-- 6 JOIN
-- 1.
SELECT matchid, player FROM goal 
  WHERE teamid = 'GER'
-- 2.
SELECT o.id, o.stadium, o.team1, o.team2
FROM goal c
INNER JOIN game o
ON c.matchid = o.id
WHERE matchid = 1012 
AND player ='Lars Bender'
-- 3.
SELECT player, teamid, stadium, mdate
  FROM game JOIN goal ON (id=matchid)
WHERE teamid ='GER'
-- 4.
SELECT team1, team2, player
  FROM game JOIN goal ON (id=matchid)
WHERE player LIKE 'Mario%'
-- 5.
SELECT player, teamid, coach, gtime
  FROM goal JOIN eteam ON (teamid=id)
 WHERE gtime<=10
-- 6.
SELECT mdate, teamname
  FROM game JOIN eteam ON (team1=eteam.id)
 WHERE coach = 'Fernando Santos'
-- 7.
SELECT player
  FROM game JOIN goal ON (matchid=id)
 WHERE stadium = 'National Stadium, Warsaw'
-- 8.// the sql zoo does not accept  as a pass my code 

SELECT DISTINCT player
  FROM game JOIN goal ON matchid = id 
 WHERE (team1 = 'GER' OR team2 = 'GER')
   AND teamid!='GER'
-- 9.
SELECT 	teamname, ( SELECT COUNT(player)
  FROM eteam y JOIN goal   ON id=teamid 
 
WHERE x.teamname = y.teamname ) FROM eteam x

GROUP BY teamname
-- 10.
SELECT 	stadium, ( SELECT COUNT(player)
  FROM game y JOIN goal   ON matchid=id 
 
WHERE x.stadium = y.stadium ) FROM game x

GROUP BY stadium
-- 11.
SELECT matchid, mdate,  ( SELECT COUNT(player)
  FROM game  JOIN goal y  ON matchid=id 
 
WHERE x.matchid = y.matchid )
  FROM game  JOIN goal x ON matchid = id 

 WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid, mdate
-- 12.
SELECT matchid, mdate,  ( SELECT COUNT(player)
  FROM game  JOIN goal y  ON matchid=id 
 
WHERE x.matchid = y.matchid
AND teamid='GER' )
  FROM game  JOIN goal x ON matchid = id 

 WHERE (team1 = 'GER' AND teamid ='GER' OR team2 = 'GER' AND teamid ='GER')
GROUP BY matchid, mdate
-- 13.
SELECT mdate,
  team1,
  SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1,
  team2,
  SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
  FROM game LEFT JOIN goal ON matchid = id 
GROUP BY mdate,matchid,team1,team2;


-- 7 More JOIN operations
-- 1.
SELECT id, title
 FROM movie
 WHERE yr=1962
-- 2.
SELECT yr 
  FROM movie 
  WHERE title='Citizen Kane'
-- 3.
SELECT id,title, yr FROM movie
 WHERE title LIKE 'Star Trek%'
 ORDER BY yr
-- 4.
SELECT id FROM actor
WHERE name = 'Glenn Close'
-- 5.
SELECT id FROM movie
WHERE title = 'Casablanca'
-- 6.
SELECT name
  FROM casting, actor
  WHERE movieid=(SELECT id 
             FROM movie 
             WHERE title='Casablanca')
    AND actorid=actor.id
-- 7.
SELECT name
  FROM movie, casting, actor
  WHERE title='Alien'
    AND movieid=movie.id
    AND actorid=actor.id
-- 8.
SELECT title
  FROM movie, casting, actor
 WHERE name='Harrison Ford'
    AND movieid=movie.id
    AND actorid=actor.id
-- 9.
SELECT title
  FROM movie, casting, actor
 WHERE name='Harrison Ford'
    AND movieid=movie.id
    AND actorid=actor.id
  AND ord<>1
-- 10.
SELECT title, name
  FROM movie, casting, actor
 WHERE yr=1962
    AND movieid=movie.id
    AND actorid=actor.id
    AND ord=1
-- 11.
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2
-- 12.
SELECT title, name
  FROM movie, casting, actor
  WHERE movieid=movie.id
    AND actorid=actor.id
    AND ord=1
    AND movieid IN
    (SELECT movieid FROM casting, actor
     WHERE actorid=actor.id
     AND name='Julie Andrews')
-- 13.
SELECT name
    FROM casting JOIN actor
      ON  actorid = actor.id
    WHERE ord=1
    GROUP BY name
    HAVING COUNT(movieid)>=15
-- 14.
SELECT title, COUNT(actorid)
  FROM casting,movie                
  WHERE yr=1978
        AND movieid=movie.id
  GROUP BY title
  ORDER BY 2 DESC, 1 ASC
-- 15.
SELECT DISTINCT d.name
FROM actor d JOIN casting a ON (a.actorid=d.id)
   JOIN casting b ON (a.movieid=b.movieid)
   JOIN actor c ON (b.actorid=c.id 
                AND c.name='Art Garfunkel')
  WHERE d.id!=c.id

-- 8 Using Null
-- 1.
SELECT name
FROM teacher
WHERE dept IS NULL
-- 2.
SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id)
-- 3.
SELECT teacher.name, dept.name
FROM teacher 
LEFT JOIN dept ON (teacher.dept=dept.id)
-- 4.
SELECT teacher.name, dept.name
FROM teacher 
RIGHT JOIN dept ON (teacher.dept=dept.id)
-- 5.
SELECT name, COALESCE(mobile,'07986 444 2266')
FROM teacher
-- 6.
SELECT teacher.name, COALESCE(dept.name,'None')
FROM teacher LEFT JOIN dept
ON teacher.dept=dept.id
-- 7.
SELECT COUNT(teacher.name), COUNT(mobile)
FROM teacher
-- 8.
SELECT dept.name, COUNT(teacher.name)
FROM teacher RIGHT JOIN dept
ON teacher.dept=dept.id
GROUP BY dept.name
-- 9.
SELECT name, CASE WHEN dept IN (1,2) 
THEN 'Sci'
ELSE 'Art' END
FROM teacher
-- 10.
SELECT name, CASE WHEN dept IN (1,2) 
  THEN 'Sci'
  WHEN dept = 3 
  THEN 'Art'
  ELSE 'None' END
  FROM teacher


-- 8+ Numeric Examples
-- 1.
SELECT COUNT(*) 
FROM stops
-- 2.
SELECT id 
FROM stops 
WHERE name='Craiglockhart'
-- 3.

SELECT id, name FROM stops, route
  WHERE id=stop
    AND company='LRT'
    AND num='4'
-- 4.
SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*)=2
-- 5.

SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop = 53 AND b.stop=149
-- 6.
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart'
  AND stopb.name='London Road'
-- 7.
SELECT DISTINCT R1.company, R1.num
  FROM route R1, route R2
  WHERE R1.num=R2.num AND R1.company=R2.company
    AND R1.stop=115 AND R2.stop=137
-- 8.SELECT R1.company, R1.num
  FROM route R1, route R2, stops S1, stops S2
  WHERE R1.num=R2.num AND R1.company=R2.company
    AND R1.stop=S1.id AND R2.stop=S2.id
    AND S1.name='Craiglockhart'
    AND S2.name='Tollcross'

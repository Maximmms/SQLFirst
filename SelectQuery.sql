--Задание 2
--1 Название и продолжительность самого длительного трека.
SELECT title, duration FROM tracks
WHERE duration = (SELECT MAX(duration) FROM Tracks);

--2 Название треков, продолжительность которых не менее 3,5 минут.
SELECT title, duration FROM tracks
WHERE duration >= 210;

--3 Названия сборников, вышедших в период с 2018 по 2020 год включительно.
SELECT title, release_year  FROM collections
WHERE release_year between 2018 AND 2020;

--4 Исполнители, чьё имя состоит из одного слова.
SELECT name FROM singers
WHERE POSITION(' ' IN name)=0;

--5 Название треков, которые содержат слово «мой» или «my».
SELECT title FROM tracks
WHERE title ILIKE '%мой%' OR title ILIKE '%my%';

--Задание 3
--1 Количество исполнителей в каждом жанре.
SELECT g.name, COUNT(sg.singer_id) FROM genres g
INNER JOIN singergenres sg ON g.id = sg.genre_id
GROUP BY g.name;

--2 Количество треков, вошедших в альбомы 2019–2020 годов.
SELECT a.title, a.release_year, COUNT(t.id) FROM albums a 
INNER JOIN tracks t ON a.id = t.album_id
GROUP BY a.title, a.release_year
HAVING a.release_year >=2019 and a.release_year<2020 ;

--3 Средняя продолжительность треков по каждому альбому.
SELECT a.title, AVG(t.duration) FROM albums a 
INNER JOIN tracks t ON a.id = t.album_id
GROUP BY a.title;


--4 Все исполнители, которые не выпустили альбомы в 2020 году.
SELECT s.name FROM singers s
WHERE s.singer_id NOT IN (
    SELECT als.singer_id FROM albumsinger als
    JOIN albums a ON als.album_id = a.id
    WHERE a.release_year = 2020
);

--5 Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами).
SELECT DISTINCT c.title FROM collections c
JOIN collectiontracks ct ON c.id = ct.collection_id
JOIN tracks t ON t.id = ct.track_id
JOIN albums a ON a.id  = t.album_id
JOIN albumsinger als ON a.id = als.album_id
JOIN singers s ON s.singer_id = als.singer_id
WHERE s.name = 'Queen';

--Задание 4
--1 Названия альбомов, в которых присутствуют исполнители более чем одного жанра.
SELECT DISTINCT al.title FROM albums al
JOIN albumsinger als ON al.id = als.album_id
JOIN singers s ON s.singer_id  = als.singer_id
JOIN singergenres sg ON sg.singer_id = s.singer_id
GROUP BY al.title 
HAVING COUNT(sg.genre_id) >1;

--2 Наименования треков, которые не входят в сборники.
SELECT DISTINCT t.title FROM tracks t
JOIN collectiontracks ct ON t.id = ct.track_id
INNER JOIN collections c on ct.collection_id = c.id
WHERE c.id = null;

--3 Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько.
SELECT DISTINCT s.name FROM singers s
JOIN albumsinger als ON s.singer_id = als.singer_id
JOIN albums al ON als.album_id = al.id
JOIN tracks t ON al.id = t.album_id
WHERE t.duration = (SELECT MIN(duration) FROM tracks);

--4 Названия альбомов, содержащих наименьшее количество треков.
SELECT DISTINCT a.title FROM albums a
join tracks t on a.id = t.album_id
GROUP BY a.id 
HAVING COUNT(t.id) = (
    SELECT COUNT(t2.id) AS track_count FROM tracks t2
    GROUP BY t2.album_id
    ORDER BY track_count ASC
    LIMIT 1
);
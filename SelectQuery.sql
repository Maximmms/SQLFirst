--Задание 2
--1 Название и продолжительность самого длительного трека.
SELECT title, duration FROM tracks
WHERE duration = (SELECT MAX(duration) FROM Tracks);

--2 Название треков, продолжительность которых не менее 3,5 минут.
SELECT title, duration FROM tracks
WHERE duration >= 210;

--3 Названия сборников, вышедших в период с 2018 по 2020 год включительно.
SELECT title, release_year  FROM collections
WHERE release_year>2018 AND release_year<=2020;

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
select c.title from collections c
where c.id in (
	select ct.collection_id from collectiontracks ct
	join tracks t on ct.collection_id = t.id
	where t.id in (
		select a.id from albums a
		join albumsinger als on a.id = als.album_id
		where als.album_id in (
			select s.singer_id from singers s
			where s.name = 'Queen' 
			
		)
		
	)
);


--Задание 4
--1 Названия альбомов, в которых присутствуют исполнители более чем одного жанра.
SELECT DISTINCT al.title FROM albums al
JOIN albumsinger als ON al.id = als.album_id
JOIN (
SELECT sg.singer_id FROM singergenres sg
    GROUP BY sg.singer_id
    HAVING COUNT(sg.genre_id) > 1
) AS multi_genre_singer ON als.singer_id = multi_genre_singer.singer_id;

--2 Наименования треков, которые не входят в сборники.
SELECT DISTINCT t.title FROM tracks t
JOIN collectiontracks ct ON t.id = ct.track_id
JOIN (
SELECT c.id FROM collections c 
	GROUP BY c.id
	HAVING count(c.id)=null
) AS track_without_collection ON ct.track_id = track_without_collection.id;

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
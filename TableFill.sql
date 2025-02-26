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


--2 Наименования треков, которые не входят в сборники.


--3 Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько.


--4 Названия альбомов, содержащих наименьшее количество треков.

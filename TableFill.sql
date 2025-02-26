-- Добавляем жанры
INSERT INTO genres (name) VALUES
('Rock'),
('Pop'),
('Hip-Hop');

-- Добавляем исполнителей
INSERT INTO singers (name) VALUES
('Queen'),
('Adriano Celentano'),
('Scorpions'),
('The Beatles')
('ABBA')
('Kanye West');

-- Связываем исполнителей с жанрами
INSERT INTO singergenres (singer_id, genre_id) VALUES
(1, 1), -- Queen -> Rock
(2, 2), -- Adriano Celentano -> Pop
(3, 1), -- Scorpions -> Rock
(4, 1), -- The Beatles -> Rock
(4, 2), -- The Beatles -> Pop
(5, 2), -- ABBA -> Pop
(6, 3); -- Kanye West -> Hip-Hop

-- Добавляем альбомы
INSERT INTO albums (title, release_year) VALUES
('A Night at the Opera', 1975),
('Arrival', 1976),
('La voce del padrone', 1981),
('Blackout', 1982),
('The College Dropout', 2004),
('My Beautiful Dark Twisted Fantasy', 2010),
('Sgt. Peppers Lonely Hearts Club Band', 1967),
('Abbey Road', 1969);

-- Связываем альбомы с исполнителями
INSERT INTO albumsinger (album_id, singer_id) VALUES
(1, 1), -- A Night at the Opera -> Queen
(2, 5), -- Arrival -> ABBA
(3, 2), -- La voce del padrone -> Adriano Celentano
(4, 3), -- Blackout -> Scorpions
(5, 6), -- The College Dropout -> Kanye West
(6, 6), -- My Beautiful Dark Twisted Fantasy -> Kanye West
(7, 4), -- Sgt. Peppers Lonely Hearts Club Band -> The Beatles
(8, 4); -- Abbey Road -> The Beatles

-- Добавляем треки
INSERT INTO tracks (title, duration, album_id) VALUES
('Bohemian Rhapsody', 355, 1),
('Love of My Life', 223, 1),
('Dancing Queen', 231, 2),
('Mamma Mia', 213, 2),
('Azzurro', 210, 3),
('Rock Me', 255, 4),
('Through the Wire', 221, 5),
('Power', 292, 6),
('A Day in the Life', 233, 7),
('Here Comes the Sun', 185, 8);

-- Добавляем сборники
INSERT INTO collections (title, release_year) VALUES
('Greatest Hits', 2000),
('Pop Anthems', 2010),
('Hip-Hop Classics', 2015),
('Rock Ballads', 1995);

-- Связываем треки со сборниками
INSERT INTO collectiontracks (collection_id, track_id) VALUES
(1, 1), -- Greatest Hits -> Bohemian Rhapsody
(1, 2), -- Greatest Hits -> Love of My Life
(1, 7), -- Greatest Hits -> Through the Wire
(1, 8), -- Greatest Hits -> Power
(2, 3), -- Pop Anthems -> Dancing Queen
(2, 4), -- Pop Anthems -> Mamma Mia
(3, 5), -- Hip-Hop Classics -> Azzurro
(3, 6), -- Hip-Hop Classics -> Rock Me
(4, 1), -- Rock Ballads -> Bohemian Rhapsody
(4, 2); -- Rock Ballads -> Love of My Life
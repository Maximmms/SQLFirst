CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE singers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE albums (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year INTEGER
);

CREATE TABLE tracks (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    duration INTEGER,
    album_id INTEGER REFERENCES albums(id)
);

CREATE TABLE collections (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year INTEGER
);

CREATE TABLE singergenres (
    singer_id INTEGER REFERENCES singers(id),
    genre_id INTEGER REFERENCES genres(id),
    PRIMARY KEY (singer_id, genre_id)
);

CREATE TABLE albumsinger (
    album_id INTEGER REFERENCES albums(id),
    singer_id INTEGER REFERENCES singers(id),
    PRIMARY KEY (album_id, singer_id)
);

CREATE TABLE collectiontracks (
    collection_id INTEGER REFERENCES collections(id),
    track_id INTEGER REFERENCES tracks(id),
    PRIMARY KEY (collection_id, track_id)
);
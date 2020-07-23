CREATE TABLE moodHistory (id INTEGER PRIMARY KEY, level INTEGER, description TEXT);

CREATE TABLE moodHistory (id INTEGER PRIMARY KEY, level INTEGER, description TEXT, food INTEGER, nature INTEGER, temperament INTEGER, socialization INTEGER, drive INTEGER, rest INTEGER, calm INTEGER);

CREATE TABLE moodTags (id INTEGER PRIMARY KEY, tagName TEXT, moodId INTEGER REFERENCES moodHistory(id) ON DELETE CASCADE ON UPDATE CASCADE);
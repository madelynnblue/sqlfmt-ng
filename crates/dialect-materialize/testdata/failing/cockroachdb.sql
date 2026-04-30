ALTER USER CURRENT_USER PASSWORD '123'

-- sqlfmt-corpus-separator --

ALTER USER foo WITH PASSWORD 'somepass'

-- sqlfmt-corpus-separator --

ALTER USER hash8 WITH PASSWORD 'hai'

-- sqlfmt-corpus-separator --

ALTER USER hash8 WITH PASSWORD 'hello universe'

-- sqlfmt-corpus-separator --

ALTER USER testuser PASSWORD 'cat'

-- sqlfmt-corpus-separator --

ALTER USER testuser PASSWORD 'xyz'

-- sqlfmt-corpus-separator --

ALTER USER testuser PASSWORD NULL

-- sqlfmt-corpus-separator --

ALTER USER testuser WITH PASSWORD 'abc'

-- sqlfmt-corpus-separator --

ALTER USER testuser2 WITH PASSWORD 'abc'

-- sqlfmt-corpus-separator --

ALTER USER testuser3 WITH PASSWORD 'ilov3beefjerky'

-- sqlfmt-corpus-separator --

ALTER USER testuser3 WITH PASSWORD 'xyz'

-- sqlfmt-corpus-separator --

ALTER USER userlongpassword WITH PASSWORD '987654321021'

-- sqlfmt-corpus-separator --

create table flying_roaches (check ('flying'::roach_type = 'crawling'::roach_type))
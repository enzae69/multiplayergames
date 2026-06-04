-- Run this in Supabase SQL Editor:
-- https://supabase.com/dashboard/project/ozvyymrqibpyqccgszlz/sql

CREATE TABLE IF NOT EXISTS players (
  username      text PRIMARY KEY,
  password_hash text NOT NULL,
  xp            integer NOT NULL DEFAULT 0,
  coins         integer NOT NULL DEFAULT 0,
  level         integer NOT NULL DEFAULT 1,
  wins          integer NOT NULL DEFAULT 0,
  games         integer NOT NULL DEFAULT 0,
  created_at    timestamptz DEFAULT now(),
  last_seen     timestamptz DEFAULT now()
);

ALTER TABLE players ENABLE ROW LEVEL SECURITY;
CREATE POLICY "allow_all" ON players FOR ALL USING (true) WITH CHECK (true);

-- You can drop the old leaderboard table if you want:
-- DROP TABLE IF EXISTS leaderboard;

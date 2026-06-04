-- Run this in your Supabase SQL Editor:
-- https://supabase.com/dashboard/project/ozvyymrqibpyqccgszlz/sql

CREATE TABLE IF NOT EXISTS leaderboard (
  player_name text PRIMARY KEY,
  wins        integer NOT NULL DEFAULT 0,
  games       integer NOT NULL DEFAULT 0,
  last_seen   timestamptz DEFAULT now()
);

ALTER TABLE leaderboard ENABLE ROW LEVEL SECURITY;

CREATE POLICY "public_read"   ON leaderboard FOR SELECT USING (true);
CREATE POLICY "public_insert" ON leaderboard FOR INSERT WITH CHECK (true);
CREATE POLICY "public_update" ON leaderboard FOR UPDATE USING (true);

-- Run in Supabase SQL Editor:
-- https://supabase.com/dashboard/project/ozvyymrqibpyqccgszlz/sql

-- Friends table
CREATE TABLE IF NOT EXISTS cr_friends (
  id          bigserial PRIMARY KEY,
  from_user   text NOT NULL,
  to_user     text NOT NULL,
  status      text NOT NULL DEFAULT 'pending', -- 'pending' | 'accepted'
  created_at  timestamptz DEFAULT now(),
  UNIQUE(from_user, to_user)
);
ALTER TABLE cr_friends ENABLE ROW LEVEL SECURITY;
CREATE POLICY "cr_friends_all" ON cr_friends FOR ALL USING (true) WITH CHECK (true);

-- Invites / match lobby
CREATE TABLE IF NOT EXISTS cr_invites (
  id          bigserial PRIMARY KEY,
  from_user   text NOT NULL,
  to_user     text NOT NULL,
  match_id    text NOT NULL,
  status      text NOT NULL DEFAULT 'pending', -- 'pending' | 'accepted' | 'declined'
  created_at  timestamptz DEFAULT now()
);
ALTER TABLE cr_invites ENABLE ROW LEVEL SECURITY;
CREATE POLICY "cr_invites_all" ON cr_invites FOR ALL USING (true) WITH CHECK (true);

-- Match state (realtime sync)
CREATE TABLE IF NOT EXISTS cr_matches (
  match_id    text PRIMARY KEY,
  host        text NOT NULL,
  guest       text,
  state       jsonb NOT NULL DEFAULT '{}',
  updated_at  timestamptz DEFAULT now()
);
ALTER TABLE cr_matches ENABLE ROW LEVEL SECURITY;
CREATE POLICY "cr_matches_all" ON cr_matches FOR ALL USING (true) WITH CHECK (true);

-- Lobby table (new multiplayer system)
CREATE TABLE IF NOT EXISTS cr_lobbies (
  code        text PRIMARY KEY,
  host        text NOT NULL,
  mode        text NOT NULL DEFAULT '1v1', -- '1v1' | '2v2'
  max_players int NOT NULL DEFAULT 2,
  players     jsonb NOT NULL DEFAULT '[]',
  status      text NOT NULL DEFAULT 'waiting', -- 'waiting' | 'starting' | 'done'
  created_at  timestamptz DEFAULT now()
);
ALTER TABLE cr_lobbies ENABLE ROW LEVEL SECURITY;
CREATE POLICY "cr_lobbies_all" ON cr_lobbies FOR ALL USING (true) WITH CHECK (true);

-- Enable realtime for these tables
ALTER PUBLICATION supabase_realtime ADD TABLE cr_invites;
ALTER PUBLICATION supabase_realtime ADD TABLE cr_matches;
ALTER PUBLICATION supabase_realtime ADD TABLE cr_lobbies;

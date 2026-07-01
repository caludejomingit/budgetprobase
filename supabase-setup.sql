-- Run this once in Supabase: Dashboard → SQL Editor → New query → paste → Run
--
-- This version adds real user accounts (Supabase Auth). Every row is tied to
-- the person who created it, and Row Level Security makes sure nobody can
-- see or edit anyone else's transactions or budgets — even with the anon key.
--
-- NOTE: if you already ran an older version of this file (without user_id),
-- run the "drop table" lines below first to start clean. That will delete
-- any existing rows, since there'd be no way to know which user they belong to.

drop table if exists transactions cascade;
drop table if exists budgets cascade;

create table transactions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  type text not null check (type in ('income','expense')),
  amount numeric not null,
  category text not null,
  date date not null,
  note text,
  created_at timestamptz default now()
);

create table budgets (
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  category text not null,
  amount numeric not null,
  primary key (user_id, category)
);

create index if not exists transactions_user_date_idx on transactions (user_id, date desc);

-- Row Level Security: every user can only see and modify their own rows.
alter table transactions enable row level security;
alter table budgets enable row level security;

drop policy if exists "public access" on transactions;
drop policy if exists "users manage own transactions" on transactions;
create policy "users manage own transactions" on transactions
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists "public access" on budgets;
drop policy if exists "users manage own budgets" on budgets;
create policy "users manage own budgets" on budgets
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- Optional but recommended for quick testing: in your Supabase dashboard go to
-- Authentication → Providers → Email and turn OFF "Confirm email" so new
-- accounts can log in immediately after signing up. Leave it ON for a
-- production app so people verify their email address first.

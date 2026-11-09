-- 想要清单审批 · 数据库结构
-- 用法：在 Supabase 的 SQL Editor 里，对一个全新的项目整段运行一次。

create table public.members (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  name text not null,
  avatar text not null default '🙂',
  created_at timestamptz not null default now()
);

create table public.requests (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  member_id uuid references public.members(id) on delete cascade,
  kind text not null check (kind in ('do','avoid')),
  title text not null,
  reason text,
  money_cost numeric(12,2),
  time_cost_minutes integer,
  gain_money numeric(12,2),
  gain_time_minutes integer,
  cost_note text,
  gain_note text,
  status text not null default 'pending' check (status in ('pending','approved','rejected')),
  decision_reason text,
  created_at timestamptz not null default now(),
  review_at timestamptz,
  decided_at timestamptz,
  rush boolean not null default false,
  deadline_at timestamptz,
  round integer not null default 1,
  history jsonb not null default '[]'::jsonb
);

create table public.votes (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  request_id uuid not null references public.requests(id) on delete cascade,
  member_id uuid not null references public.members(id) on delete cascade,
  round integer not null default 1,
  decision text not null check (decision in ('approve','reject')),
  reason text not null,
  created_at timestamptz not null default now(),
  unique (request_id, round, member_id)
);

create table public.settings (
  user_id uuid primary key default auth.uid() references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb
);

-- 行级安全：每个登录账号只能读写自己的数据
alter table public.members  enable row level security;
alter table public.requests enable row level security;
alter table public.votes    enable row level security;
alter table public.settings enable row level security;

grant select, insert, update, delete on
  public.members, public.requests, public.votes, public.settings to authenticated;

create policy "own rows only" on public.members  for all to authenticated
  using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));
create policy "own rows only" on public.requests for all to authenticated
  using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));
create policy "own rows only" on public.votes    for all to authenticated
  using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));
create policy "own rows only" on public.settings for all to authenticated
  using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));

-- 实时同步
alter publication supabase_realtime add table
  public.members, public.requests, public.votes, public.settings;

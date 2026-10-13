-- Run this once in the Supabase SQL editor.
create table if not exists public.lisa_state (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.lisa_state enable row level security;

create policy "lisa_state select own" on public.lisa_state for select using (auth.uid() = user_id);
create policy "lisa_state insert own" on public.lisa_state for insert with check (auth.uid() = user_id);
create policy "lisa_state update own" on public.lisa_state for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "lisa_state delete own" on public.lisa_state for delete using (auth.uid() = user_id);

-- Lets a signed-in user delete their own account (and, by cascade, their row above).
create or replace function public.delete_my_account() returns void
language plpgsql security definer set search_path = public as $$
begin
  delete from auth.users where id = auth.uid();
end $$;
revoke all on function public.delete_my_account() from public, anon;
grant execute on function public.delete_my_account() to authenticated;

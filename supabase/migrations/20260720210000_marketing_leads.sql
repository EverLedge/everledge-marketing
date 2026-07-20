-- Leads captured by the IHT calculator on the marketing homepage.
-- Anonymous visitors may insert; nobody can read or modify via the public API.
create table if not exists public.marketing_leads (
  id uuid primary key default gen_random_uuid(),
  email text not null,
  source text,
  estate_value numeric,
  iht_estimate numeric,
  created_at timestamptz not null default now()
);

alter table public.marketing_leads enable row level security;

create policy "Anyone can submit a lead"
  on public.marketing_leads
  for insert
  to anon, authenticated
  with check (true);

-- No select/update/delete policies: leads are write-only from the public API.
-- Read them from the Supabase dashboard or with the service role key.
revoke select, update, delete on public.marketing_leads from anon, authenticated;

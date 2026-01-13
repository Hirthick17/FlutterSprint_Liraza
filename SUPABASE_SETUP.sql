-- ==============================================================================
-- LIRAZA SUPABASE SCHEMA SETUP 
-- Copy and paste this into the SQL Editor of your Supabase Dashboard
-- ==============================================================================

-- 1. Enable UUID extension
create extension if not exists "uuid-ossp";

-- 2. Create PROFILES table (Public user data linked to Auth)
create table public.profiles (
  id uuid references auth.users not null primary key,
  full_name text,
  avatar_url text,
  updated_at timestamp with time zone,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 3. Create MOOD_LOGS table (To store mood tracking data)
create table public.mood_logs (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references public.profiles(id) not null,
  score int not null check (score >= 1 and score <= 10),
  emotion text not null, -- 'happy', 'sad', 'anxious' etc.
  note text,
  activities text[], -- Array of strings e.g. ['work', 'sleep']
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 4. Create CHAT_SESSIONS table (To group messages)
create table public.chat_sessions (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references public.profiles(id) not null,
  title text default 'New Conversation',
  summary text, -- AI generated summary of the chat
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  updated_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 5. Create MESSAGES table (Individual chat messages)
create table public.messages (
  id uuid default uuid_generate_v4() primary key,
  session_id uuid references public.chat_sessions(id) on delete cascade not null,
  sender text not null check (sender in ('user', 'ai')),
  content text not null,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 6. Create THERAPISTS table (For directory)
create table public.therapists (
  id uuid default uuid_generate_v4() primary key,
  name text not null,
  specialty text not null,
  location text not null,
  rating numeric(2,1) default 5.0,
  image_url text,
  available boolean default true,
  contact_number text,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- ==============================================================================
-- ROW LEVEL SECURITY (RLS) POLICIES
-- This ensures users can only see their OWN data
-- ==============================================================================

-- Enable RLS on all tables
alter table public.profiles enable row level security;
alter table public.mood_logs enable row level security;
alter table public.chat_sessions enable row level security;
alter table public.messages enable row level security;
alter table public.therapists enable row level security;

-- PROFILES Policies
create policy "Public profiles are viewable by everyone." 
  on public.profiles for select using (true);

create policy "Users can update their own profile." 
  on public.profiles for update using (auth.uid() = id);

-- MOOD_LOGS Policies
create policy "Users can view own mood logs." 
  on public.mood_logs for select using (auth.uid() = user_id);

create policy "Users can insert own mood logs." 
  on public.mood_logs for insert with check (auth.uid() = user_id);

-- CHAT Policies
create policy "Users can view own chat sessions." 
  on public.chat_sessions for select using (auth.uid() = user_id);

create policy "Users can insert own chat sessions." 
  on public.chat_sessions for insert with check (auth.uid() = user_id);

-- MESSAGES Policies
create policy "Users can view messages from their sessions." 
  on public.messages for select using (
    exists (
      select 1 from public.chat_sessions 
      where id = messages.session_id and user_id = auth.uid()
    )
  );

create policy "Users can insert messages to their sessions." 
  on public.messages for insert with check (
    exists (
      select 1 from public.chat_sessions 
      where id = messages.session_id and user_id = auth.uid()
    )
  );

-- THERAPISTS Policies
create policy "Therapists are viewable by everyone" 
  on public.therapists for select using (true);

-- ==============================================================================
-- AUTOMATION TRIGGERS
-- ==============================================================================

-- Function to handle new user signup
create or replace function public.handle_new_user() 
returns trigger as $$
begin
  insert into public.profiles (id, full_name, avatar_url)
  values (
    new.id, 
    new.raw_user_meta_data->>'full_name', 
    new.raw_user_meta_data->>'avatar_url'
  );
  return new;
end;
$$ language plpgsql security definer;

-- Trigger to call the function on signup
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

-- Seed some dummy therapists data
insert into public.therapists (name, specialty, location, rating, contact_number)
values 
('Dr. Sarah Johnson', 'Anxiety & Depression', 'New York, NY', 4.9, '+1-555-0101'),
('Dr. Rajesh Kumar', 'Stress Management', 'Mumbai, India', 4.8, '+91-98765-43210'),
('Dr. Emily Chen', 'Relationship Counseling', 'San Francisco, CA', 4.7, '+1-555-0102');

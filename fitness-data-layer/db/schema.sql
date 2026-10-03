CREATE SCHEMA IF NOT EXISTS gowebapp;

CREATE TABLE IF NOT EXISTS gowebapp.users (
  id BIGSERIAL PRIMARY KEY,
  email TEXT NOT NULL UNIQUE,
  password_hash TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS gowebapp.exercises (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT NOT NULL REFERENCES gowebapp.users(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (user_id, name)
);

CREATE TABLE IF NOT EXISTS gowebapp.workouts (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT NOT NULL REFERENCES gowebapp.users(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS gowebapp.images (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT NOT NULL REFERENCES gowebapp.users(id) ON DELETE CASCADE,
  exercise_id BIGINT REFERENCES gowebapp.exercises(id) ON DELETE SET NULL,
  url TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS gowebapp.sets (
  id BIGSERIAL PRIMARY KEY,
  workout_id BIGINT NOT NULL REFERENCES gowebapp.workouts(id) ON DELETE CASCADE,
  exercise_id BIGINT NOT NULL REFERENCES gowebapp.exercises(id) ON DELETE RESTRICT,
  set_number INTEGER NOT NULL CHECK (set_number > 0),
  reps INTEGER NOT NULL CHECK (reps > 0),
  weight_kg NUMERIC(6,2) NOT NULL CHECK (weight_kg >= 0),
  UNIQUE (workout_id, exercise_id, set_number)
);

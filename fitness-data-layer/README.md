# Fitness data layer

This lesson creates a local PostgreSQL database and initializes the fitness schema.

## Start PostgreSQL

From this directory, set a local development password and start the container:

```sh
export POSTGRES_PASSWORD=devpassword
docker compose up -d
docker compose ps
```

The default host port is 5432. If it is unavailable, use another host port:

```sh
POSTGRES_PORT=5555 docker compose up -d
```

## Apply the schema

The schema file is mounted into the container at `/workspace/db/schema.sql`:

```sh
docker compose exec -T db psql -U postgres -d postgres -f /workspace/db/schema.sql
```

## Verify the tables

```sh
docker compose exec db psql -U postgres -d postgres -c '\dt gowebapp.*'
```

The command should list `exercises`, `images`, `sets`, `users`, and `workouts`.

## Stop the database

```sh
docker compose down
```

The named volume preserves data between container restarts. To remove that local data intentionally:

```sh
docker compose down -v
```

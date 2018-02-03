# PostgreSQL

Postgres gets installed by Homebrew. However, I encountered an error the first time I ran `psql`.

> `psql: could not connect to server`

Some things I tried that got it working.

```bash
rm -rf /usr/local/var/postgres && initdb /usr/local/var/postgres -E utf8
```

Start server
```bash
pg_ctl -D /usr/local/var/postgres -l logfile start
```

```bash
createdb
```

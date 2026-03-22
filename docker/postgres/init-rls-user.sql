#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    DO \$\$
    BEGIN
        IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'crm_user') THEN
            CREATE ROLE crm_user WITH LOGIN PASSWORD '${DBPASSWORD}';
        END IF;
    END
    \$\$;

    GRANT ALL PRIVILEGES ON DATABASE ${POSTGRES_DB} TO crm_user;
    GRANT ALL ON SCHEMA public TO crm_user;
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO crm_user;
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO crm_user;
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON FUNCTIONS TO crm_user;
EOSQL

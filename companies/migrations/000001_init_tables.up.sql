CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TYPE company_type AS ENUM ('Corporations', 'NonProfit', 'Cooperative', 'Sole Proprietorship');

CREATE TABLE IF NOT EXISTS companies (
    id UUID NOT NULL DEFAULT uuid_generate_v1(), -- Unique identifier of company (primary key)
    name varchar(15) NOT NULL, -- Company name
    description varchar(3000) NULL, -- Company description
    amount int NOT NULL,-- Amount of Employees
    registered bool NOT NULL, -- Registered
    type company_type NOT NULL,-- Type of Company
    created_at TIMESTAMP   NOT NULL DEFAULT timezone('utc'::text, now()),
    updated_at TIMESTAMP   NULL,
    CONSTRAINT companies_pkey PRIMARY KEY (id),
    CONSTRAINT companies_name_uniq UNIQUE (name)
    );

COMMENT ON TABLE companies IS 'Table of companies';
COMMENT ON COLUMN companies.id IS 'Unique identifier of company';
COMMENT ON COLUMN companies.name IS 'Company name';
COMMENT ON COLUMN companies.description IS 'Company description';
COMMENT ON COLUMN companies.amount IS 'Amount of Employees';
COMMENT ON COLUMN companies.registered IS 'Registered';
COMMENT ON COLUMN companies.type IS 'Type of Company';
COMMENT ON COLUMN companies.created_at IS 'Creation date and time';
COMMENT ON COLUMN companies.updated_at IS 'Updating date and time';


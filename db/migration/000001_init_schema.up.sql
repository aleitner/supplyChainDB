CREATE TYPE partner_type AS ENUM ('warehouser', 'importer', 'exporter', 'forwarder', 'supplier');
CREATE TYPE entity_type AS ENUM('products', 'orders', 'items', 'batches', 'shipments', 'users', 'containers', 'projects', 'milestones', 'tasks');
CREATE TYPE entity_ref AS (id bigint, type entity_type);

CREATE TABLE permissions (
    id bigserial PRIMARY KEY,
    owner bigint references partners(id) NOT NULL,
--     group bigint references partners(id) NOT NULL
    read varchar(1),
    write varchar(1),
    delete varchar(1)
);

CREATE TABLE entities_permissions (
    id bigserial PRIMARY KEY,
    entity_ref entity_ref NOT NULL,
    permissions_id bigint references permissions(id)
);

CREATE TABLE tags (
    id bigserial PRIMARY KEY,
    name varchar NOT NULL,
    color varchar(7) NOT NULL,
    description text NOT NULL,
    applicable_entity_types entity_type[] NOT NULL DEFAULT '{}',

--     Meta data
    created_at timestamptz NOT NULL DEFAULT (now()),
    updated_at timestamptz NOT NULL,
    created_by_id bigint references partners(id) NOT NULL,
    updated_by_id bigint references partners(id) NOT NULL
);

CREATE TABLE tags_entities (
    id bigserial PRIMARY KEY,
    tag_id bigint references tags(id) NOT NULL,
    entity_ref entity_ref NOT NULL
);

CREATE TABLE partners (
    id bigserial PRIMARY KEY,
    name varchar NOT NULL,
    code integer,
    type partner_type NOT NULL,
    phone_number varchar,
    country_code varchar(3),
    region varchar,
    locality varchar,
    street varchar,
    postal_code varchar(12)
);

CREATE TABLE users
(
    id   bigserial PRIMARY KEY,
    name varchar NOT NULL
);


CREATE TABLE staff (
    id bigserial PRIMARY KEY,
    name varchar NOT NULL,
    email_address varchar,
    position varchar,
    partner_id bigint references partners(id) on delete set NULL
);

CREATE TABLE orders (
    id bigserial PRIMARY KEY,
    purchase_order_number varchar NOT NULL,
    proforma_invoice_number varchar,
    importer bigint references partners(id),
    exporter bigint references partners(id),
    contract_delivery_date timestamptz,
    incoterms varchar(3),
    place_of_delivery varchar,
    currency varchar(3),
    memo text,
    created_at timestamptz NOT NULL DEFAULT (now()),
    created_by_id bigint references users(id) NOT NULL
);

-- CREATE INDEX ON accounts (owner);

COMMENT ON COLUMN partners.country_code IS 'must be iso3';

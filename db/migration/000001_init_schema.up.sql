CREATE TYPE partner_type AS ENUM ('warehouser', 'importer', 'exporter', 'forwarder', 'supplier');

-- *************** SqlDBM: PostgreSQL ****************;
-- ***************************************************;


-- ************************************** users

CREATE TABLE users
(
    "id"            bigserial NOT NULL,
    surname       varchar(50) NOT NULL,
    first_name    varchar(255) NOT NULL,
    email_address varchar(255) NOT NULL,
    password      varchar(255) NOT NULL,
    department_id bigint NOT NULL,
    role          varchar(50) NULL,
    about         text NULL,
    super_user    boolean NOT NULL,
    created_at    timestamp with time zone NOT NULL,
    updated_at    timestamp with time zone NOT NULL,
    CONSTRAINT PK_staff PRIMARY KEY ( "id" )
);



COMMENT ON COLUMN users.first_name IS 'email address';





-- ************************************** timelines

CREATE TABLE timelines
(
    "id"   bigserial NOT NULL,
    name varchar(255) NOT NULL,
    CONSTRAINT PK_timeline PRIMARY KEY ( "id" )
);








-- ************************************** timeline_sea_transit

CREATE TABLE timeline_sea_transit
(
    "id"                bigserial NOT NULL,
    load_port         varchar(255) NULL,
    departure_date    timestamp with time zone NULL,
    discharge_port    varchar(255) NULL,
    arrival_date      timestamp with time zone NULL,
    voyage_no         varchar(255) NULL,
    carrier           varchar(255) NULL,
    vessel_name       varchar(255) NULL,
    imo_no            varchar(255) NULL,
    booking_no        varchar(255) NULL,
    bill_of_lading_no varchar(255) NULL,
    memo              text NULL,
    CONSTRAINT PK_timeline_sea_transit PRIMARY KEY ( "id" )
);








-- ************************************** timeline_road_transit_courier

CREATE TABLE timeline_road_transit_courier
(
    "id"                 bigserial NOT NULL,
    from_location_type varchar(255) NOT NULL,
    from_location      varchar(255) NOT NULL,
    departure_date     timestamp with time zone NOT NULL,
    to_location_type   varchar(255) NOT NULL,
    to_location        varchar(255) NOT NULL,
    arrival_date       timestamp with time zone NOT NULL,
    tracking_no        varchar(255) NOT NULL,
    booking_no         varchar(255) NOT NULL,
    memo               text NOT NULL,
    CONSTRAINT PK_road_transit PRIMARY KEY ( "id" )
);








-- ************************************** timeline_ferry_train

CREATE TABLE timeline_ferry_train
(
    "id"                 bigserial NOT NULL,
    departure_location varchar(255) NULL,
    departure_date     timestamp with time zone NULL,
    arrival_location   varchar(255) NULL,
    arrival_date       timestamp with time zone NULL,
    tracking_no        varchar(255) NULL,
    booking_no         varchar(255) NULL,
    memo               text NULL,
    CONSTRAINT PK_timeline_ferry PRIMARY KEY ( "id" )
);








-- ************************************** timeline_customs_clearance

CREATE TABLE timeline_customs_clearance
(
    "id"               bigserial NOT NULL,
    declaration_date timestamp with time zone NULL,
    permission_date  timestamp with time zone NULL,
    permission_no    varchar(255) NULL,
    code             varchar(255) NULL,
    approved         boolean NOT NULL,
    memo             text NULL,
    CONSTRAINT PK_timeline_customs_clearance PRIMARY KEY ( "id" )
);








-- ************************************** timeline_air_transit

CREATE TABLE timeline_air_transit
(
    "id"             bigserial NOT NULL,
    load_port      varchar(255) NULL,
    departure_date timestamp with time zone NULL,
    discharge_port varchar(255) NULL,
    arrival_date   timestamp with time zone NULL,
    flight_no      varchar(255) NULL,
    carrier        varchar(255) NULL,
    awb_no         varchar(255) NULL,
    booking_no     varchar(255) NULL,
    memo           text NULL,
    CONSTRAINT PK_timeline_sea_transit_copy PRIMARY KEY ( "id" )
);








-- ************************************** templates

CREATE TABLE templates
(
    "id"         bigserial NOT NULL,
    name       varchar(255) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    CONSTRAINT PK_templates PRIMARY KEY ( "id" )
);








-- ************************************** tasks

CREATE TABLE tasks
(
    "id"               bigserial NOT NULL,
    name             varchar(255) NOT NULL,
    due_date         timestamp with time zone NULL,
    start_date       timestamp with time zone NULL,
    status           varchar(255) NULL,
    in_progress_date timestamp with time zone NULL,
    completed_date   timestamp with time zone NULL,
    approval_date    timestamp with time zone NULL,
    approved         boolean NOT NULL,
    description      text NULL,
    CONSTRAINT PK_tasks PRIMARY KEY ( "id" )
);








-- ************************************** shipments

CREATE TABLE shipments
(
    "id"                  bigserial NOT NULL,
    shipment_no         varchar(255) NOT NULL,
    bill_of_lading_no   varchar(255) NULL,
    bill_of_lading_date timestamp with time zone NULL,
    booking_no          varchar(255) NULL,
    booking_date        timestamp with time zone NULL,
    invoice_no          varchar(255) NULL,
    contract_no         varchar(255) NULL,
    incoterms           varchar(255) NULL,
    load_type           varchar(255) NULL,
    memo                text NULL,
    total_packages      bigint NULL,
    weight              varchar(255) NULL,
    volume              varchar(255) NULL,
    CONSTRAINT PK_shipments PRIMARY KEY ( "id" )
);








-- ************************************** projects

CREATE TABLE projects
(
    "id"          bigserial NOT NULL,
    name        varchar(255) NOT NULL,
    due_date    timestamp with time zone NULL,
    description text NULL,
    CONSTRAINT PK_projects PRIMARY KEY ( "id" )
);








-- ************************************** product_specifications

CREATE TABLE product_specifications
(
    "id"          bigserial NOT NULL,
    unit_type   varchar(255) NULL,
    unit_price  varchar(255) NULL,
    material    varchar(255) NULL,
    unit_weight varchar(255) NULL,
    unit_width  varchar(255) NULL,
    unit_height varchar(255) NULL,
    unit_depth  varchar(255) NULL,
    CONSTRAINT PK_product_specifications PRIMARY KEY ( "id" )
);








-- ************************************** product_codes

CREATE TABLE product_codes
(
    "id"   bigserial NOT NULL,
    jan  varchar(255) NULL,
    hs   varchar(255) NULL,
    gtin varchar(255) NULL,
    upc  varchar(255) NULL,
    ean  varchar(255) NULL,
    CONSTRAINT PK_product_codes PRIMARY KEY ( "id" )
);








-- ************************************** packaging

CREATE TABLE packaging
(
    "id"       bigserial NOT NULL,
    name     varchar(255) NULL,
    capacity varchar(255) NULL,
    weight   varchar(255) NULL,
    width    varchar(255) NULL,
    height   varchar(255) NULL,
    "depth"    varchar(255) NULL,
    CONSTRAINT PK_product_packaging PRIMARY KEY ( "id" )
);








-- ************************************** organizations

CREATE TABLE organizations
(
    "id"           bigserial NOT NULL,
    name         varchar NOT NULL,
    code         integer NULL,
    phone_number varchar(15) NULL,
    country_code varchar(3) NULL,
    region       varchar(255) NULL,
    locality     varchar(255) NULL,
    street       varchar(255) NULL,
    postal_code  varchar(12) NULL,
    created_at   timestamp with time zone NOT NULL,
    updated_at   timestamp with time zone NOT NULL,
    CONSTRAINT PK_partners PRIMARY KEY ( "id" )
);



COMMENT ON COLUMN organizations.country_code IS 'must be iso3';





-- ************************************** orders

CREATE TABLE orders
(
    "id"                      bigserial NOT NULL,
    purchase_order_number   varchar(255) NOT NULL,
    proforma_invoice_number varchar(255) NULL,
    contract_delivery_date  timestamp with time zone NULL,
    incoterms               varchar(3) NULL,
    place_of_delivery       varchar(255) NULL,
    currency                varchar(3) NULL,
    memo                    text NULL,
    created_at              timestamp with time zone NOT NULL DEFAULT (now()),
    updated_at              timestamp with time zone NOT NULL,
    CONSTRAINT PK_orders PRIMARY KEY ( "id" )
);








-- ************************************** documents

CREATE TABLE documents
(
    "id"          bigserial NOT NULL,
    name        varchar(255) NOT NULL,
    location    varchar(255) NOT NULL,
    description text NOT NULL,
    extention   varchar(255) NOT NULL,
    CONSTRAINT PK_documents PRIMARY KEY ( "id" )
);








-- ************************************** custom_fields

CREATE TABLE custom_fields
(
    "id"         bigserial NOT NULL,
    field      varchar(255) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    CONSTRAINT PK_custom_fields PRIMARY KEY ( "id" )
);








-- ************************************** containers

CREATE TABLE containers
(
    "id"                      bigserial NOT NULL,
    container_no            varchar(255) NOT NULL,
    container_type          varchar(255) NULL,
    agreed_arrival_date     timestamp with time zone NULL,
    actual_arrival_date     timestamp with time zone NULL,
    start_date              timestamp with time zone NULL,
    port_duration           varchar(255) NULL,
    yard_name               varchar(255) NULL,
    yard_departure_date     timestamp with time zone NULL,
    yard_departure_approval boolean NOT NULL,
    actual_arrival_approval boolean NOT NULL,
    agreed_arrival_approval boolean NOT NULL,
    CONSTRAINT PK_container PRIMARY KEY ( "id" )
);








-- ************************************** timelines_custom_fields

CREATE TABLE timelines_custom_fields
(
    "id"              bigserial NOT NULL,
    timeline_id     bigint NOT NULL,
    custom_field_id bigint NOT NULL,
    CONSTRAINT PK_timelines_custom_fields PRIMARY KEY ( "id" ),
    CONSTRAINT FK_575 FOREIGN KEY ( timeline_id ) REFERENCES timelines ( "id" ),
    CONSTRAINT FK_581 FOREIGN KEY ( custom_field_id ) REFERENCES custom_fields ( "id" )
);

CREATE INDEX fkIdx_576 ON timelines_custom_fields
(
 timeline_id
);

CREATE INDEX fkIdx_582 ON timelines_custom_fields
(
 custom_field_id
);








-- ************************************** timeline_custom_event

CREATE TABLE timeline_custom_event
(
    "id"              bigserial NOT NULL,
    name            varchar(255) NULL,
    organization_id bigint NULL,
    location        varchar(255) NULL,
    start_date      timestamp with time zone NULL,
    end_date        timestamp with time zone NULL,
    memo            text NULL,
    approved        boolean NOT NULL,
    CONSTRAINT PK_timeline_custom_event PRIMARY KEY ( "id" ),
    CONSTRAINT FK_811 FOREIGN KEY ( organization_id ) REFERENCES organizations ( "id" )
);

CREATE INDEX fkIdx_812 ON timeline_custom_event
(
 organization_id
);








-- ************************************** templates_users

CREATE TABLE templates_users
(
    "id"          bigserial NOT NULL,
    template_id bigint NOT NULL,
    user_id     bigint NOT NULL,
    is_owner    boolean NOT NULL,
    created_at  timestamp with time zone NOT NULL,
    CONSTRAINT PK_templates_users PRIMARY KEY ( "id" ),
    CONSTRAINT FK_284 FOREIGN KEY ( template_id ) REFERENCES templates ( "id" ),
    CONSTRAINT FK_288 FOREIGN KEY ( user_id ) REFERENCES users ( "id" )
);

CREATE INDEX fkIdx_285 ON templates_users
(
 template_id
);

CREATE INDEX fkIdx_289 ON templates_users
(
 user_id
);








-- ************************************** templates_custom_fields

CREATE TABLE templates_custom_fields
(
    "id"              bigserial NOT NULL,
    template_id     bigint NOT NULL,
    custom_field_id bigint NOT NULL,
    created_at      timestamp with time zone NOT NULL,
    modified_at     timestamp with time zone NOT NULL,
    CONSTRAINT PK_templates_custom_fields PRIMARY KEY ( "id" ),
    CONSTRAINT FK_175 FOREIGN KEY ( template_id ) REFERENCES templates ( "id" ),
    CONSTRAINT FK_178 FOREIGN KEY ( custom_field_id ) REFERENCES custom_fields ( "id" )
);

CREATE INDEX fkIdx_176 ON templates_custom_fields
(
 template_id
);

CREATE INDEX fkIdx_179 ON templates_custom_fields
(
 custom_field_id
);








-- ************************************** tags

CREATE TABLE tags
(
    "id"            bigserial NOT NULL,
    name          varchar(255) NOT NULL,
    color         varchar(7) NULL,
    description   text NULL,
    created_at    timestamp with time zone NOT NULL DEFAULT (now()),
    updated_at    timestamp with time zone NOT NULL,
    created_by_id bigint NOT NULL,
    CONSTRAINT PK_tags PRIMARY KEY ( "id" ),
    CONSTRAINT FK_255 FOREIGN KEY ( created_by_id ) REFERENCES users ( "id" )
);

CREATE INDEX fkIdx_256 ON tags
(
 created_by_id
);








-- ************************************** shipments_organizations

CREATE TABLE shipments_organizations
(
    "id"              bigserial NOT NULL,
    shipment_id     bigint NOT NULL,
    organization_id bigint NOT NULL,
    partner_type    partner_type NOT NULL,
    CONSTRAINT PK_shipments_organizations PRIMARY KEY ( "id" ),
    CONSTRAINT FK_522 FOREIGN KEY ( shipment_id ) REFERENCES shipments ( "id" ),
    CONSTRAINT FK_525 FOREIGN KEY ( organization_id ) REFERENCES organizations ( "id" )
);

CREATE INDEX fkIdx_523 ON shipments_organizations
(
 shipment_id
);

CREATE INDEX fkIdx_526 ON shipments_organizations
(
 organization_id
);








-- ************************************** shipments_documents

CREATE TABLE shipments_documents
(
    "id"          bigserial NOT NULL,
    shipment_id bigint NOT NULL,
    document_id bigint NOT NULL,
    CONSTRAINT PK_shipments_documents PRIMARY KEY ( "id" ),
    CONSTRAINT FK_949 FOREIGN KEY ( document_id ) REFERENCES documents ( "id" ),
    CONSTRAINT FK_967 FOREIGN KEY ( shipment_id ) REFERENCES shipments ( "id" )
);

CREATE INDEX fkIdx_950 ON shipments_documents
(
 document_id
);

CREATE INDEX fkIdx_968 ON shipments_documents
(
 shipment_id
);








-- ************************************** shipments_custom_fields

CREATE TABLE shipments_custom_fields
(
    "id"              bigserial NOT NULL,
    shipment_id     bigint NOT NULL,
    custom_field_id bigint NOT NULL,
    CONSTRAINT PK_shipments_custom_fields PRIMARY KEY ( "id" ),
    CONSTRAINT FK_760 FOREIGN KEY ( shipment_id ) REFERENCES shipments ( "id" ),
    CONSTRAINT FK_763 FOREIGN KEY ( custom_field_id ) REFERENCES custom_fields ( "id" )
);

CREATE INDEX fkIdx_761 ON shipments_custom_fields
(
 shipment_id
);

CREATE INDEX fkIdx_764 ON shipments_custom_fields
(
 custom_field_id
);








-- ************************************** projects_organizations

CREATE TABLE projects_organizations
(
    "id"              bigserial NOT NULL,
    project_id      bigint NOT NULL,
    organization_id bigint NOT NULL,
    CONSTRAINT PK_projects_organizations PRIMARY KEY ( "id" ),
    CONSTRAINT FK_885 FOREIGN KEY ( project_id ) REFERENCES projects ( "id" ),
    CONSTRAINT FK_888 FOREIGN KEY ( organization_id ) REFERENCES organizations ( "id" )
);

CREATE INDEX fkIdx_886 ON projects_organizations
(
 project_id
);

CREATE INDEX fkIdx_889 ON projects_organizations
(
 organization_id
);








-- ************************************** projects_documents

CREATE TABLE projects_documents
(
    "id"          bigserial NOT NULL,
    project_id  bigint NOT NULL,
    document_id bigint NOT NULL,
    CONSTRAINT PK_projects_documents PRIMARY KEY ( "id" ),
    CONSTRAINT FK_952 FOREIGN KEY ( document_id ) REFERENCES documents ( "id" ),
    CONSTRAINT FK_964 FOREIGN KEY ( project_id ) REFERENCES projects ( "id" )
);

CREATE INDEX fkIdx_953 ON projects_documents
(
 document_id
);

CREATE INDEX fkIdx_965 ON projects_documents
(
 project_id
);








-- ************************************** products

CREATE TABLE products
(
    "id"                        bigserial NOT NULL,
    name                      varchar(255) NOT NULL,
    images                    varchar(255)[] NOT NULL,
    serial                    varchar(255) NOT NULL,
    product_codes_id          bigint NOT NULL,
    country_of_origin         varchar(255) NOT NULL,
    product_specifications_id bigint NOT NULL,
    CONSTRAINT PK_products PRIMARY KEY ( "id" ),
    CONSTRAINT FK_332 FOREIGN KEY ( product_codes_id ) REFERENCES product_codes ( "id" ),
    CONSTRAINT FK_363 FOREIGN KEY ( product_specifications_id ) REFERENCES product_specifications ( "id" )
);

CREATE INDEX fkIdx_333 ON products
(
 product_codes_id
);

CREATE INDEX fkIdx_364 ON products
(
 product_specifications_id
);








-- ************************************** organizations_users

CREATE TABLE organizations_users
(
    "id"              bigserial NOT NULL,
    user_id         bigint NOT NULL,
    organization_id bigint NOT NULL,
    is_owner        boolean NOT NULL,
    created_at      timestamp with time zone NOT NULL,
    updated_at      timestamp with time zone NOT NULL,
    CONSTRAINT PK_organizations_users PRIMARY KEY ( "id" ),
    CONSTRAINT FK_145 FOREIGN KEY ( user_id ) REFERENCES users ( "id" ),
    CONSTRAINT FK_148 FOREIGN KEY ( organization_id ) REFERENCES organizations ( "id" )
);

CREATE INDEX fkIdx_146 ON organizations_users
(
 user_id
);

CREATE INDEX fkIdx_149 ON organizations_users
(
 organization_id
);








-- ************************************** organizations_partner_types

CREATE TABLE organizations_partner_types
(
    "id"              bigserial NOT NULL,
    organization_id bigint NOT NULL,
    partner_type    partner_type NOT NULL,
    CONSTRAINT PK_organization_types PRIMARY KEY ( "id" )
);

CREATE INDEX fkIdx_239 ON organizations_partner_types
(
 organization_id
);








-- ************************************** orders_organizations

CREATE TABLE orders_organizations
(
    "id"              bigserial NOT NULL,
    order_id        bigint NOT NULL,
    organization_id bigint NOT NULL,
    partner_type    partner_type NOT NULL,
    CONSTRAINT PK_orders_partners PRIMARY KEY ( "id" ),
    CONSTRAINT FK_297 FOREIGN KEY ( order_id ) REFERENCES orders ( "id" ),
    CONSTRAINT FK_300 FOREIGN KEY ( organization_id ) REFERENCES organizations ( "id" )
);

CREATE INDEX fkIdx_298 ON orders_organizations
(
 order_id
);

CREATE INDEX fkIdx_301 ON orders_organizations
(
 organization_id
);








-- ************************************** orders_documents

CREATE TABLE orders_documents
(
    "id"          bigserial NOT NULL,
    order_id    bigint NOT NULL,
    document_id bigint NOT NULL,
    CONSTRAINT PK_orders_documents PRIMARY KEY ( "id" ),
    CONSTRAINT FK_958 FOREIGN KEY ( document_id ) REFERENCES documents ( "id" ),
    CONSTRAINT FK_961 FOREIGN KEY ( order_id ) REFERENCES orders ( "id" )
);

CREATE INDEX fkIdx_959 ON orders_documents
(
 document_id
);

CREATE INDEX fkIdx_962 ON orders_documents
(
 order_id
);








-- ************************************** orders_custom_fields

CREATE TABLE orders_custom_fields
(
    "id"              bigserial NOT NULL,
    order_id        bigint NOT NULL,
    custom_field_id bigint NOT NULL,
    CONSTRAINT PK_orders_custom_fields PRIMARY KEY ( "id" ),
    CONSTRAINT FK_413 FOREIGN KEY ( order_id ) REFERENCES orders ( "id" ),
    CONSTRAINT FK_416 FOREIGN KEY ( custom_field_id ) REFERENCES custom_fields ( "id" )
);

CREATE INDEX fkIdx_414 ON orders_custom_fields
(
 order_id
);

CREATE INDEX fkIdx_417 ON orders_custom_fields
(
 custom_field_id
);








-- ************************************** milestones

CREATE TABLE milestones
(
    "id"                        bigserial NOT NULL,
    name                      varchar(255) NOT NULL,
    due_date                  timestamp with time zone NULL,
    estimated_completion_date timestamp with time zone NULL,
    status                    varchar(255) NULL,
    description               text NULL,
    project_id                bigint NULL,
    CONSTRAINT PK_milestones PRIMARY KEY ( "id" ),
    CONSTRAINT FK_897 FOREIGN KEY ( project_id ) REFERENCES projects ( "id" )
);

CREATE INDEX fkIdx_898 ON milestones
(
 project_id
);








-- ************************************** departments

CREATE TABLE departments
(
    "id"              bigserial NOT NULL,
    name            varchar(50) NOT NULL,
    organization_id bigint NOT NULL,
    created_at      timestamp with time zone NOT NULL,
    updated_at      timestamp with time zone NOT NULL,
    CONSTRAINT PK_departments PRIMARY KEY ( "id" ),
    CONSTRAINT FK_130 FOREIGN KEY ( organization_id ) REFERENCES organizations ( "id" )
);

CREATE INDEX fkIdx_131 ON departments
(
 organization_id
);








-- ************************************** custom_field_values

CREATE TABLE custom_field_values
(
    "id"              bigserial NOT NULL,
    custom_field_id bigint NOT NULL,
    value           varchar(255) NOT NULL,
    value_type      varchar(50) NOT NULL,
    created_at      timestamp with time zone NOT NULL,
    updated_at      timestamp with time zone NOT NULL,
    CONSTRAINT PK_custom_field_values PRIMARY KEY ( "id" ),
    CONSTRAINT FK_436 FOREIGN KEY ( custom_field_id ) REFERENCES custom_fields ( "id" )
);

CREATE INDEX fkIdx_437 ON custom_field_values
(
 custom_field_id
);








-- ************************************** containers_custom_fields

CREATE TABLE containers_custom_fields
(
    "id"              bigserial NOT NULL,
    container_id    bigint NOT NULL,
    custom_field_id bigint NOT NULL,
    CONSTRAINT PK_containers_custom_fields PRIMARY KEY ( "id" ),
    CONSTRAINT FK_852 FOREIGN KEY ( container_id ) REFERENCES containers ( "id" ),
    CONSTRAINT FK_855 FOREIGN KEY ( custom_field_id ) REFERENCES custom_fields ( "id" )
);

CREATE INDEX fkIdx_853 ON containers_custom_fields
(
 container_id
);

CREATE INDEX fkIdx_856 ON containers_custom_fields
(
 custom_field_id
);








-- ************************************** timelines_tags

CREATE TABLE timelines_tags
(
    "id"          bigserial NOT NULL,
    timeline_id bigint NOT NULL,
    tag_id      bigint NOT NULL,
    CONSTRAINT PK_timelines_tags PRIMARY KEY ( "id" ),
    CONSTRAINT FK_572 FOREIGN KEY ( timeline_id ) REFERENCES timelines ( "id" ),
    CONSTRAINT FK_578 FOREIGN KEY ( tag_id ) REFERENCES tags ( "id" )
);

CREATE INDEX fkIdx_573 ON timelines_tags
(
 timeline_id
);

CREATE INDEX fkIdx_579 ON timelines_tags
(
 tag_id
);








-- ************************************** tasks_tags

CREATE TABLE tasks_tags
(
    "id"      bigserial NOT NULL,
    task_id bigint NOT NULL,
    tag_id  bigint NOT NULL,
    CONSTRAINT PK_tasks_tags PRIMARY KEY ( "id" ),
    CONSTRAINT FK_915 FOREIGN KEY ( task_id ) REFERENCES tasks ( "id" ),
    CONSTRAINT FK_918 FOREIGN KEY ( tag_id ) REFERENCES tags ( "id" )
);

CREATE INDEX fkIdx_916 ON tasks_tags
(
 task_id
);

CREATE INDEX fkIdx_919 ON tasks_tags
(
 tag_id
);








-- ************************************** shipments_transits

CREATE TABLE shipments_transits
(
    "id"                   bigserial NOT NULL,
    shipment_id          bigint NOT NULL,
    sea_transit_id       bigint NOT NULL,
    air_transit_id       bigint NOT NULL,
    road_transit_id      bigint NOT NULL,
    ferry_id             bigint NOT NULL,
    customs_clearance_id bigint NOT NULL,
    custom_event_id      bigint NOT NULL,
    train_id             bigint NOT NULL,
    courier_id           bigint NOT NULL,
    warehousing_id       bigint NOT NULL,
    inspection_id        bigint NOT NULL,
    CONSTRAINT PK_shipments_transits PRIMARY KEY ( "id" ),
    CONSTRAINT FK_754 FOREIGN KEY ( shipment_id ) REFERENCES shipments ( "id" ),
    CONSTRAINT FK_769 FOREIGN KEY ( road_transit_id ) REFERENCES timeline_road_transit_courier ( "id" ),
    CONSTRAINT FK_772 FOREIGN KEY ( sea_transit_id ) REFERENCES timeline_sea_transit ( "id" ),
    CONSTRAINT FK_775 FOREIGN KEY ( air_transit_id ) REFERENCES timeline_air_transit ( "id" ),
    CONSTRAINT FK_784 FOREIGN KEY ( customs_clearance_id ) REFERENCES timeline_customs_clearance ( "id" ),
    CONSTRAINT FK_793 FOREIGN KEY ( ferry_id ) REFERENCES timeline_ferry_train ( "id" ),
    CONSTRAINT FK_796 FOREIGN KEY ( custom_event_id ) REFERENCES timeline_custom_event ( "id" ),
    CONSTRAINT FK_817 FOREIGN KEY ( train_id ) REFERENCES timeline_ferry_train ( "id" ),
    CONSTRAINT FK_820 FOREIGN KEY ( courier_id ) REFERENCES timeline_road_transit_courier ( "id" ),
    CONSTRAINT FK_823 FOREIGN KEY ( warehousing_id ) REFERENCES timeline_custom_event ( "id" ),
    CONSTRAINT FK_826 FOREIGN KEY ( inspection_id ) REFERENCES timeline_custom_event ( "id" )
);

CREATE INDEX fkIdx_755 ON shipments_transits
(
 shipment_id
);

CREATE INDEX fkIdx_770 ON shipments_transits
(
 road_transit_id
);

CREATE INDEX fkIdx_773 ON shipments_transits
(
 sea_transit_id
);

CREATE INDEX fkIdx_776 ON shipments_transits
(
 air_transit_id
);

CREATE INDEX fkIdx_785 ON shipments_transits
(
 customs_clearance_id
);

CREATE INDEX fkIdx_794 ON shipments_transits
(
 ferry_id
);

CREATE INDEX fkIdx_797 ON shipments_transits
(
 custom_event_id
);

CREATE INDEX fkIdx_818 ON shipments_transits
(
 train_id
);

CREATE INDEX fkIdx_821 ON shipments_transits
(
 courier_id
);

CREATE INDEX fkIdx_824 ON shipments_transits
(
 warehousing_id
);

CREATE INDEX fkIdx_827 ON shipments_transits
(
 inspection_id
);








-- ************************************** shipments_tags

CREATE TABLE shipments_tags
(
    "id"          bigserial NOT NULL,
    shipment_id bigint NOT NULL,
    tag_id      bigint NOT NULL,
    CONSTRAINT PK_shipments_tags PRIMARY KEY ( "id" ),
    CONSTRAINT FK_757 FOREIGN KEY ( shipment_id ) REFERENCES shipments ( "id" ),
    CONSTRAINT FK_766 FOREIGN KEY ( tag_id ) REFERENCES tags ( "id" )
);

CREATE INDEX fkIdx_758 ON shipments_tags
(
 shipment_id
);

CREATE INDEX fkIdx_767 ON shipments_tags
(
 tag_id
);








-- ************************************** projects_tags

CREATE TABLE projects_tags
(
    "id"         bigserial NOT NULL,
    project_id bigint NOT NULL,
    tag_id     bigint NOT NULL,
    CONSTRAINT PK_project_tags PRIMARY KEY ( "id" ),
    CONSTRAINT FK_876 FOREIGN KEY ( project_id ) REFERENCES projects ( "id" ),
    CONSTRAINT FK_879 FOREIGN KEY ( tag_id ) REFERENCES tags ( "id" )
);

CREATE INDEX fkIdx_877 ON projects_tags
(
 project_id
);

CREATE INDEX fkIdx_880 ON projects_tags
(
 tag_id
);








-- ************************************** products_tags

CREATE TABLE products_tags
(
    "id"         bigserial NOT NULL,
    product_id bigint NOT NULL,
    tag_id     bigint NOT NULL,
    CONSTRAINT PK_products_tags PRIMARY KEY ( "id" ),
    CONSTRAINT FK_483 FOREIGN KEY ( product_id ) REFERENCES products ( "id" ),
    CONSTRAINT FK_486 FOREIGN KEY ( tag_id ) REFERENCES tags ( "id" )
);

CREATE INDEX fkIdx_484 ON products_tags
(
 product_id
);

CREATE INDEX fkIdx_487 ON products_tags
(
 tag_id
);








-- ************************************** products_packaging

CREATE TABLE products_packaging
(
    "id"           bigserial NOT NULL,
    product_id   bigint NOT NULL,
    packaging_id bigint NOT NULL,
    CONSTRAINT PK_products_packaging PRIMARY KEY ( "id" ),
    CONSTRAINT FK_395 FOREIGN KEY ( product_id ) REFERENCES products ( "id" ),
    CONSTRAINT FK_398 FOREIGN KEY ( packaging_id ) REFERENCES packaging ( "id" )
);

CREATE INDEX fkIdx_396 ON products_packaging
(
 product_id
);

CREATE INDEX fkIdx_399 ON products_packaging
(
 packaging_id
);








-- ************************************** products_documents

CREATE TABLE products_documents
(
    "id"          bigserial NOT NULL,
    product_id  bigint NOT NULL,
    document_id bigint NOT NULL,
    CONSTRAINT PK_products_documents PRIMARY KEY ( "id" ),
    CONSTRAINT FK_955 FOREIGN KEY ( document_id ) REFERENCES documents ( "id" ),
    CONSTRAINT FK_970 FOREIGN KEY ( product_id ) REFERENCES products ( "id" )
);

CREATE INDEX fkIdx_956 ON products_documents
(
 document_id
);

CREATE INDEX fkIdx_971 ON products_documents
(
 product_id
);








-- ************************************** products_custom_fields

CREATE TABLE products_custom_fields
(
    "id"              bigserial NOT NULL,
    product_id      bigint NOT NULL,
    custom_field_id bigint NOT NULL,
    CONSTRAINT PK_products_custom_fields PRIMARY KEY ( "id" ),
    CONSTRAINT FK_445 FOREIGN KEY ( product_id ) REFERENCES products ( "id" ),
    CONSTRAINT FK_448 FOREIGN KEY ( custom_field_id ) REFERENCES custom_fields ( "id" )
);

CREATE INDEX fkIdx_446 ON products_custom_fields
(
 product_id
);

CREATE INDEX fkIdx_449 ON products_custom_fields
(
 custom_field_id
);








-- ************************************** orders_tags

CREATE TABLE orders_tags
(
    "id"       bigserial NOT NULL,
    order_id bigint NOT NULL,
    tag_id   bigint NOT NULL,
    CONSTRAINT PK_orders_tags PRIMARY KEY ( "id" ),
    CONSTRAINT FK_464 FOREIGN KEY ( order_id ) REFERENCES orders ( "id" ),
    CONSTRAINT FK_467 FOREIGN KEY ( tag_id ) REFERENCES tags ( "id" )
);

CREATE INDEX fkIdx_465 ON orders_tags
(
 order_id
);

CREATE INDEX fkIdx_468 ON orders_tags
(
 tag_id
);








-- ************************************** items

CREATE TABLE items
(
    "id"            bigserial NOT NULL,
    item_number   varchar(255) NOT NULL,
    product_id    bigint NOT NULL,
    unit_price    bigint NOT NULL,
    unit_currency varchar(3) NOT NULL,
    delivery_date timestamp with time zone NOT NULL,
    memo          text NULL,
    created_at    timestamp with time zone NOT NULL,
    updated_at    timestamp with time zone NOT NULL,
    CONSTRAINT PK_items PRIMARY KEY ( "id" ),
    CONSTRAINT FK_313 FOREIGN KEY ( product_id ) REFERENCES products ( "id" )
);

CREATE INDEX fkIdx_314 ON items
(
 product_id
);








-- ************************************** documents_tags

CREATE TABLE documents_tags
(
    "id"          bigserial NOT NULL,
    document_id bigint NOT NULL,
    tag_id      bigint NOT NULL,
    CONSTRAINT PK_documents_tags PRIMARY KEY ( "id" ),
    CONSTRAINT FK_931 FOREIGN KEY ( document_id ) REFERENCES documents ( "id" ),
    CONSTRAINT FK_934 FOREIGN KEY ( tag_id ) REFERENCES tags ( "id" )
);

CREATE INDEX fkIdx_932 ON documents_tags
(
 document_id
);

CREATE INDEX fkIdx_935 ON documents_tags
(
 tag_id
);








-- ************************************** departments_users

CREATE TABLE departments_users
(
    "id"            bigserial NOT NULL,
    user_id       bigint NOT NULL,
    department_id bigint NOT NULL,
    is_owner      boolean NOT NULL,
    created_at    timestamp with time zone NOT NULL,
    updated_at    timestamp with time zone NOT NULL,
    CONSTRAINT PK_departments_users PRIMARY KEY ( "id" ),
    CONSTRAINT FK_136 FOREIGN KEY ( user_id ) REFERENCES users ( "id" ),
    CONSTRAINT FK_139 FOREIGN KEY ( department_id ) REFERENCES departments ( "id" )
);

CREATE INDEX fkIdx_137 ON departments_users
(
 user_id
);

CREATE INDEX fkIdx_140 ON departments_users
(
 department_id
);








-- ************************************** containers_tags

CREATE TABLE containers_tags
(
    "id"           bigserial NOT NULL,
    container_id bigint NOT NULL,
    tag_id       bigint NOT NULL,
    CONSTRAINT PK_containers_tags PRIMARY KEY ( "id" ),
    CONSTRAINT FK_849 FOREIGN KEY ( container_id ) REFERENCES containers ( "id" ),
    CONSTRAINT FK_858 FOREIGN KEY ( tag_id ) REFERENCES tags ( "id" )
);

CREATE INDEX fkIdx_850 ON containers_tags
(
 container_id
);

CREATE INDEX fkIdx_859 ON containers_tags
(
 tag_id
);








-- ************************************** timelines_transits

CREATE TABLE timelines_transits
(
    "id"          bigserial NOT NULL,
    timeline_id bigint NOT NULL,
    transit_it  bigint NOT NULL,
    CONSTRAINT PK_table_558 PRIMARY KEY ( "id" ),
    CONSTRAINT FK_560 FOREIGN KEY ( timeline_id ) REFERENCES timelines ( "id" ),
    CONSTRAINT FK_973 FOREIGN KEY ( transit_it ) REFERENCES shipments_transits ( "id" )
);

CREATE INDEX fkIdx_561 ON timelines_transits
(
 timeline_id
);

CREATE INDEX fkIdx_974 ON timelines_transits
(
 transit_it
);








-- ************************************** items_tags

CREATE TABLE items_tags
(
    "id"      bigserial NOT NULL,
    item_id bigint NOT NULL,
    tag_id  bigint NOT NULL,
    CONSTRAINT PK_items_tags PRIMARY KEY ( "id" ),
    CONSTRAINT FK_474 FOREIGN KEY ( item_id ) REFERENCES items ( "id" ),
    CONSTRAINT FK_477 FOREIGN KEY ( tag_id ) REFERENCES tags ( "id" )
);

CREATE INDEX fkIdx_475 ON items_tags
(
 item_id
);

CREATE INDEX fkIdx_478 ON items_tags
(
 tag_id
);








-- ************************************** items_custom_fields

CREATE TABLE items_custom_fields
(
    "id"              bigserial NOT NULL,
    item_id         bigint NOT NULL,
    custom_field_id bigint NOT NULL,
    CONSTRAINT PK_items_custom_fields PRIMARY KEY ( "id" ),
    CONSTRAINT FK_426 FOREIGN KEY ( item_id ) REFERENCES items ( "id" ),
    CONSTRAINT FK_429 FOREIGN KEY ( custom_field_id ) REFERENCES custom_fields ( "id" )
);

CREATE INDEX fkIdx_427 ON items_custom_fields
(
 item_id
);

CREATE INDEX fkIdx_430 ON items_custom_fields
(
 custom_field_id
);








-- ************************************** batches

CREATE TABLE batches
(
    "id"                  bigserial NOT NULL,
    batch_no            varchar(255) NOT NULL,
    item_id             bigint NOT NULL,
    desired_date        timestamp with time zone NOT NULL,
    delivery_date       timestamp with time zone NOT NULL,
    expiry_date         timestamp with time zone NOT NULL,
    initial_quantity    varchar(255) NULL,
    preshipped_quantity varchar(255) NULL,
    shipped_quantity    varchar(255) NULL,
    postshipped_quanity varchar(255) NULL,
    delivered_quantity  varchar(255) NULL,
    packaging_id        bigint NOT NULL,
    CONSTRAINT PK_batches PRIMARY KEY ( "id" ),
    CONSTRAINT FK_385 FOREIGN KEY ( item_id ) REFERENCES items ( "id" ),
    CONSTRAINT FK_498 FOREIGN KEY ( packaging_id ) REFERENCES packaging ( "id" )
);

CREATE INDEX fkIdx_386 ON batches
(
 item_id
);

CREATE INDEX fkIdx_499 ON batches
(
 packaging_id
);








-- ************************************** batches_tags

CREATE TABLE batches_tags
(
    "id"       bigserial NOT NULL,
    batch_id bigint NOT NULL,
    tag_id   bigint NOT NULL,
    CONSTRAINT PK_batches_tags PRIMARY KEY ( "id" ),
    CONSTRAINT FK_492 FOREIGN KEY ( batch_id ) REFERENCES batches ( "id" ),
    CONSTRAINT FK_495 FOREIGN KEY ( tag_id ) REFERENCES tags ( "id" )
);

CREATE INDEX fkIdx_493 ON batches_tags
(
 batch_id
);

CREATE INDEX fkIdx_496 ON batches_tags
(
 tag_id
);








-- ************************************** batches_custom_fields

CREATE TABLE batches_custom_fields
(
    "id"              bigserial NOT NULL,
    batch_id        bigint NOT NULL,
    custom_field_id bigint NOT NULL,
    CONSTRAINT PK_batches_custom_fields PRIMARY KEY ( "id" ),
    CONSTRAINT FK_454 FOREIGN KEY ( batch_id ) REFERENCES batches ( "id" ),
    CONSTRAINT FK_457 FOREIGN KEY ( custom_field_id ) REFERENCES custom_fields ( "id" )
);

CREATE INDEX fkIdx_455 ON batches_custom_fields
(
 batch_id
);

CREATE INDEX fkIdx_458 ON batches_custom_fields
(
 custom_field_id
);








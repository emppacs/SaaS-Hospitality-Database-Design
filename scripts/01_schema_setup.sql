-- -- DROP TABLES
DROP TABLE IF EXISTS support_ticket CASCADE;
DROP TABLE IF EXISTS support_engineer CASCADE;
DROP TABLE IF EXISTS subscription CASCADE;
DROP TABLE IF EXISTS subscription_status CASCADE;
DROP TABLE IF EXISTS contract CASCADE;
DROP TABLE IF EXISTS contract_status CASCADE;
DROP TABLE IF EXISTS billing CASCADE;
DROP TABLE IF EXISTS billing_status CASCADE;
DROP TABLE IF EXISTS app_user CASCADE;
DROP TABLE IF EXISTS client CASCADE;
DROP TABLE IF EXISTS address CASCADE;
DROP TABLE IF EXISTS country CASCADE;
DROP TABLE IF EXISTS region CASCADE;
DROP TABLE IF EXISTS ticket_status CASCADE;
DROP TABLE IF EXISTS contract_type CASCADE;
DROP TABLE IF EXISTS ticket_category CASCADE;


-- -----------------------------
-- TABLES
-- -----------------------------

CREATE TABLE country
(
  country_id   serial      NOT NULL,
  country_name varchar(50),
  PRIMARY KEY (country_id)
);

CREATE TABLE region
(
  region_id   serial      NOT NULL,
  region_name varchar(50) NOT NULL UNIQUE,
  description varchar(50),
  PRIMARY KEY (region_id)
);

CREATE TABLE address
(
  address_id  serial       NOT NULL,
  country_id  integer      NOT NULL,
  street      varchar(100) NOT NULL,
  city        varchar(50),
  postal_code varchar(10),
  PRIMARY KEY (address_id)
);

CREATE TABLE client
(
  client_id     serial       NOT NULL,
  client_name   varchar(100) NOT NULL UNIQUE,
  region_id     integer      NOT NULL,
  address_id    integer      NOT NULL,
  email         varchar(100) UNIQUE,
  industry      varchar(50)  DEFAULT 'Hospitality',
  active        boolean      DEFAULT TRUE,
  last_update   timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (client_id)
);

CREATE TABLE contract_status
(
  contract_status_id   serial      NOT NULL,
  contract_status_name varchar(50) NOT NULL UNIQUE,
  PRIMARY KEY (contract_status_id)
);

CREATE TABLE contract
(
  contract_id        serial      NOT NULL,
  client_id          integer     NOT NULL,
  contract_type      varchar(50),
  end_date           date        NOT NULL,
  signed_date        date        NOT NULL,
  start_date         date        NOT NULL,
  contract_status_id integer     NOT NULL,
  PRIMARY KEY (contract_id)
);

CREATE TABLE subscription_status
(
  subscription_status_id   serial      NOT NULL,
  subscription_status_name varchar(50) UNIQUE,
  PRIMARY KEY (subscription_status_id)
);

CREATE TABLE subscription
(
  subscription_id        serial      NOT NULL,
  contract_id            integer     NOT NULL,
  start_date             date        NOT NULL,
  end_date               date        NOT NULL,
  subscription_status_id integer     NOT NULL,
  PRIMARY KEY (subscription_id)
);

CREATE TABLE billing_status
(
  billing_status_id   serial      NOT NULL,
  billing_status_name varchar(50) NOT NULL UNIQUE,
  PRIMARY KEY (billing_status_id)
);

CREATE TABLE billing
(
  invoice_id        serial      NOT NULL,
  client_id         integer     NOT NULL,
  subscription_id   integer     NOT NULL,
  invoice_date      date        NOT NULL,
  amount            decimal(10,2) NOT NULL CHECK (amount > 0),
  billing_status_id integer     NOT NULL,
  PRIMARY KEY (invoice_id)
);

CREATE TABLE app_user
(
  user_id       serial       NOT NULL,
  client_id     integer      NOT NULL,
  first_name    varchar(50)  NOT NULL,
  last_name     varchar(50)  NOT NULL,
  email         varchar(100),
  role          varchar(50),
  supervisor_id integer,
  last_update   timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id)
);

CREATE TABLE support_engineer
(
  engineer_id serial       NOT NULL,
  first_name  varchar(50)  NOT NULL,
  last_name   varchar(50)  NOT NULL,
  email       varchar(100),
  region_id   integer      NOT NULL,
  PRIMARY KEY (engineer_id)
);

CREATE TABLE ticket_status
(
  ticket_status_id   serial      NOT NULL,
  ticket_status_name varchar(50) NOT NULL UNIQUE,
  PRIMARY KEY (ticket_status_id)
);

CREATE TABLE support_ticket
(
  ticket_id         serial       NOT NULL,
  user_id           integer      NOT NULL,
  engineer_id       integer      NOT NULL,
  ticket_status_id  integer      NOT NULL,
  issue_description varchar(200) NOT NULL,
  created_date      date,
  closed_date       date,
  PRIMARY KEY (ticket_id)
);

-- Contract Type Table
CREATE TABLE contract_type
(
  contract_type_id   serial       NOT NULL,
  contract_type_name varchar(50)  NOT NULL UNIQUE,
  PRIMARY KEY (contract_type_id)
);

-- Ticket Category Table
CREATE TABLE ticket_category
(
  ticket_category_id   serial       NOT NULL,
  ticket_category_name varchar(50)  NOT NULL UNIQUE,
  PRIMARY KEY (ticket_category_id)
);

-- -----------------------------
-- FOREIGN KEYS
-- -----------------------------
ALTER TABLE client
  ADD CONSTRAINT FK_region_TO_client
    FOREIGN KEY (region_id)
    REFERENCES region (region_id);

ALTER TABLE client
  ADD CONSTRAINT FK_address_TO_client
    FOREIGN KEY (address_id)
    REFERENCES address (address_id);

ALTER TABLE address
  ADD CONSTRAINT FK_country_TO_address
    FOREIGN KEY (country_id)
    REFERENCES country (country_id);

ALTER TABLE contract
  ADD CONSTRAINT FK_client_TO_contract
    FOREIGN KEY (client_id)
    REFERENCES client (client_id);

ALTER TABLE contract
  ADD COLUMN contract_type_id integer NOT NULL;

ALTER TABLE contract
  ADD CONSTRAINT FK_contract_type_TO_contract
    FOREIGN KEY (contract_type_id)
    REFERENCES contract_type(contract_type_id);

ALTER TABLE contract
  ADD CONSTRAINT FK_contract_status_TO_contract
    FOREIGN KEY (contract_status_id)
    REFERENCES contract_status (contract_status_id);

ALTER TABLE subscription
  ADD CONSTRAINT FK_contract_TO_subscription
    FOREIGN KEY (contract_id)
    REFERENCES contract (contract_id);

ALTER TABLE subscription
  ADD CONSTRAINT FK_subscription_status_TO_subscription
    FOREIGN KEY (subscription_status_id)
    REFERENCES subscription_status (subscription_status_id);

ALTER TABLE billing
  ADD CONSTRAINT FK_client_TO_billing
    FOREIGN KEY (client_id)
    REFERENCES client (client_id);

ALTER TABLE billing
  ADD CONSTRAINT FK_subscription_TO_billing
    FOREIGN KEY (subscription_id)
    REFERENCES subscription (subscription_id);

ALTER TABLE billing
  ADD CONSTRAINT FK_billing_status_TO_billing
    FOREIGN KEY (billing_status_id)
    REFERENCES billing_status (billing_status_id);

ALTER TABLE app_user
  ADD CONSTRAINT FK_client_TO_app_user
    FOREIGN KEY (client_id)
    REFERENCES client (client_id);

ALTER TABLE app_user
  ADD CONSTRAINT FK_supervisor_TO_app_user
    FOREIGN KEY (supervisor_id)
    REFERENCES app_user (user_id);

ALTER TABLE support_engineer
  ADD CONSTRAINT FK_region_TO_support_engineer
    FOREIGN KEY (region_id)
    REFERENCES region (region_id);

ALTER TABLE support_ticket
  ADD CONSTRAINT FK_app_user_TO_support_ticket
    FOREIGN KEY (user_id)
    REFERENCES app_user (user_id);

ALTER TABLE support_ticket
  ADD CONSTRAINT FK_support_engineer_TO_support_ticket
    FOREIGN KEY (engineer_id)
    REFERENCES support_engineer (engineer_id);

ALTER TABLE support_ticket
  ADD CONSTRAINT FK_ticket_status_TO_support_ticket
    FOREIGN KEY (ticket_status_id)
    REFERENCES ticket_status (ticket_status_id);

ALTER TABLE support_ticket
  ADD COLUMN ticket_category_id integer NOT NULL;

ALTER TABLE support_ticket
  ADD CONSTRAINT FK_ticket_category_TO_support_ticket
    FOREIGN KEY (ticket_category_id)
    REFERENCES ticket_category(ticket_category_id);


ALTER TABLE contract
DROP column contract_type;
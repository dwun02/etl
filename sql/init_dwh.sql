CREATE SCHEMA IF NOT EXISTS staging;
CREATE SCHEMA IF NOT EXISTS dw;

CREATE TABLE IF NOT EXISTS staging.stg_sales (
    order_id TEXT,
    order_date DATE,
    store_id TEXT,
    store_name TEXT,
    barangay TEXT,
    city TEXT,
    product_id TEXT,
    product_name TEXT,
    category TEXT,
    quantity INT,
    unit_price NUMERIC(10,2),
    line_total NUMERIC(10,2),
    batch_id TEXT
);

CREATE TABLE IF NOT EXISTS dw.dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE,
    day_of_week TEXT,
    is_weekend BOOLEAN,
    month INT,
    month_name TEXT,
    quarter INT,
    year INT
);

CREATE TABLE IF NOT EXISTS dw.dim_store (
    store_key SERIAL PRIMARY KEY,
    store_id TEXT UNIQUE,
    store_name TEXT,
    barangay TEXT,
    city TEXT
);

CREATE TABLE IF NOT EXISTS dw.dim_product (
    product_key SERIAL PRIMARY KEY,
    product_id TEXT UNIQUE,
    product_name TEXT,
    category TEXT
);

CREATE TABLE IF NOT EXISTS dw.fact_sales (
    order_id TEXT,
    date_key INT REFERENCES dw.dim_date(date_key),
    store_key INT REFERENCES dw.dim_store(store_key),
    product_key INT REFERENCES dw.dim_product(product_key),
    quantity INT,
    unit_price NUMERIC(10,2),
    line_total NUMERIC(10,2),
    batch_id TEXT,
    UNIQUE (order_id, product_key)
);

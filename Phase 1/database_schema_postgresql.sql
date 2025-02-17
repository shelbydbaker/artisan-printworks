-- PostgreSQL Database Schema for Large Format Print Business

-- Customers Table
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    loyalty_points INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Orders Table
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id) ON DELETE CASCADE,
    total_price DECIMAL(10,2) NOT NULL,
    discount_applied DECIMAL(10,2) DEFAULT 0,
    tax_amount DECIMAL(10,2) DEFAULT 0,
    status VARCHAR(50) CHECK (status IN ('Pending', 'Printing', 'Shipped', 'Completed')),
    expected_delivery_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Order Status History Table
CREATE TABLE order_status_history (
    status_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id) ON DELETE CASCADE,
    status VARCHAR(50) NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Inventory Management Table
CREATE TABLE inventory (
    inventory_id SERIAL PRIMARY KEY,
    item_name VARCHAR(255) NOT NULL,
    category VARCHAR(100) NOT NULL,
    stock_quantity INT NOT NULL,
    average_daily_usage INT DEFAULT 0,
    reorder_threshold INT NOT NULL,
    restock_alert BOOLEAN DEFAULT FALSE,
    supplier_name VARCHAR(255),
    last_restocked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_ordered_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Admin Activity Log Table
CREATE TABLE admin_activity_log (
    log_id SERIAL PRIMARY KEY,
    admin_id INT REFERENCES admin_users(admin_id) ON DELETE SET NULL,
    action TEXT NOT NULL,
    target_table VARCHAR(255),
    target_id INT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Base de datos: veggie_cart
-- Crear base de datos si no existe
CREATE DATABASE IF NOT EXISTS veggie_cart CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Usar la base de datos
USE veggie_cart;

-- Crear tablas si no existen

-- Tabla de categorías de productos
CREATE TABLE IF NOT EXISTS categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla de productos
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    image VARCHAR(500) NOT NULL,
    category_id INT,
    stock INT DEFAULT 0,
    status ENUM('active', 'inactive') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_status (status),
    INDEX idx_category_id (category_id),
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla de clientes
CREATE TABLE IF NOT EXISTS customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla de órdenes
CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id VARCHAR(50) UNIQUE NOT NULL,
    customer_id INT, -- Puede ser nulo si el cliente es eliminado, pero la orden persiste
    shipping_address TEXT NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    status ENUM('pending', 'confirmed', 'preparing', 'delivered', 'cancelled') DEFAULT 'pending',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE SET NULL,
    INDEX idx_order_id (order_id),
    INDEX idx_customer_id (customer_id),
    INDEX idx_status (status),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla de items de órdenes
CREATE TABLE IF NOT EXISTS order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL, -- Relacionado con orders.id para mejor rendimiento
    product_id INT NULL, -- Nulo por si el producto se elimina después
    product_name VARCHAR(255) NOT NULL,
    product_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE SET NULL,
    INDEX idx_order_id (order_id),
    INDEX idx_product_id (product_id),
    INDEX idx_order_product (order_id, product_id) -- Índice compuesto
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla de contactos/mensajes
CREATE TABLE IF NOT EXISTS contacts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    message TEXT NOT NULL,
    status ENUM('pending', 'read', 'replied') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_status (status),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla de configuración
CREATE TABLE IF NOT EXISTS settings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    setting_key VARCHAR(100) UNIQUE NOT NULL,
    setting_value TEXT,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insertar categorías por defecto
INSERT INTO categories (id, name, description) VALUES
(1, 'bowls', 'Buddha bowls y platos completos'),
(2, 'hamburgers', 'Hamburguesas veganas'),
(3, 'salads', 'Ensaladas frescas'),
(4, 'wraps', 'Wraps y burritos'),
(5, 'smoothies', 'Smoothies y bowls'),
(6, 'pasta', 'Pastas veganas');

-- Insertar productos de ejemplo
INSERT INTO products (name, description, price, image, category_id, stock, status) VALUES
('Bowl Quinoa Power', 'Quinoa con vegetales asados, aguacate y aderezo tahini', 12.99, 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400&h=300&fit=crop', 1, 10, 'active'),
('Hamburguesa Vegana', 'Hamburguesa de garbanzos con lechuga, tomate y mayonesa vegana', 15.99, 'https://images.unsplash.com/photo-1520072959219-c595dc870360?w=400&h=300&fit=crop', 2, 8, 'active'),
('Ensalada Mediterránea', 'Mix de hojas verdes, tomate cherry, pepino y aceitunas', 10.99, 'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=400&h=300&fit=crop', 3, 15, 'active'),
('Wrap de Falafel', 'Wrap con falafel, hummus, vegetales frescos y salsa de yogur vegano', 11.99, 'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=400&h=300&fit=crop', 4, 12, 'active'),
('Smoothie Bowl', 'Bowl de smoothie de frutas con granola y semillas', 9.99, 'https://images.unsplash.com/photo-1590301157890-4810ed352733?w=400&h=300&fit=crop', 5, 20, 'active'),
('Pasta Alfredo Vegana', 'Pasta con salsa alfredo de anacardos y espinaca', 14.99, 'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=400&h=300&fit=crop', 6, 7, 'active');

-- Insertar configuración por defecto
INSERT INTO settings (setting_key, setting_value, description) VALUES
('site_name', 'Veggie cart', 'Nombre del sitio web'),
('site_description', 'Deliciosos platillos veganos', 'Descripción del sitio'),
('currency', 'USD', 'Moneda predeterminada'),
('tax_rate', '0.00', 'Tasa de impuesto'),
('shipping_cost', '0.00', 'Costo de envío'),
('contact_email', 'info@veggiedelight.com', 'Email de contacto'),
('contact_phone', '+1 234-567-8900', 'Teléfono de contacto'),
('contact_address', 'Calle Abc, Ciudad, Ciudad', 'Dirección de contacto'),
('order_confirmation_email', 'true', 'Enviar email de confirmación'),
('stock_management', 'true', 'Gestionar inventario'),
('exchange_rate', '18.50', 'Tipo de cambio USD a MXN'),
('show_dual_currency', 'true', 'Mostrar precios en ambas monedas');

-- Índices adicionales para mejorar rendimiento
CREATE INDEX idx_products_price ON products(price);
CREATE INDEX idx_orders_total ON orders(total_amount);
CREATE INDEX idx_order_items_subtotal ON order_items(subtotal);

-- Comentarios de documentación
ALTER TABLE products COMMENT = 'Tabla de productos del catálogo';
ALTER TABLE orders COMMENT = 'Tabla de órdenes de compra';
ALTER TABLE order_items COMMENT = 'Tabla de items de cada orden';
ALTER TABLE categories COMMENT = 'Tabla de categorías de productos';
ALTER TABLE customers COMMENT = 'Tabla de clientes';
ALTER TABLE contacts COMMENT = 'Tabla de mensajes de contacto';
ALTER TABLE settings COMMENT = 'Tabla de configuración del sistema';
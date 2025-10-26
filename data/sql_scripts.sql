-- 1. Crear tabla 'customers' (Clientes)
DROP TABLE IF EXISTS customers CASCADE; -- Elimina la tabla si ya existe
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    zip_code VARCHAR(10),
    registration_date DATE DEFAULT CURRENT_DATE
);

-- 2. Crear tabla 'product_categories' (Categorías de Productos)
DROP TABLE IF EXISTS product_categories CASCADE;
CREATE TABLE product_categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE
);

-- 3. Crear tabla 'products' (Productos)
DROP TABLE IF EXISTS products CASCADE;
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT,
    description TEXT,
    unit_price NUMERIC(10, 2) NOT NULL,
    product_cost NUMERIC(10, 2), -- Costo del producto, puede ser NULL inicialmente
    stock_quantity INT DEFAULT 0,
    FOREIGN KEY (category_id) REFERENCES product_categories(category_id)
);

-- 4. Crear tabla 'orders' (Pedidos)
DROP TABLE IF EXISTS orders CASCADE;
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    shipped_date TIMESTAMP, -- Fecha de envío, para cálculos de tiempo
    total_amount NUMERIC(10, 2),
    status VARCHAR(50), -- e.g., 'Pending', 'Shipped', 'Delivered', 'Cancelled'
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 5. Crear tabla 'order_details' (Detalles del Pedido)
DROP TABLE IF EXISTS order_details CASCADE;
CREATE TABLE order_details (
    order_detail_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price NUMERIC(10, 2) NOT NULL, -- Precio al momento de la venta
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


-- ####################################################################
-- INSERCIÓN DE DATOS DE EJEMPLO
-- ####################################################################

-- Clientes
INSERT INTO customers (first_name, last_name, email, phone, address, city, state, zip_code, registration_date) VALUES
('Ana', 'García', 'ana.garcia@example.com', '555-1001', 'Calle Falsa 123', 'Madrid', 'Madrid', '28001', '2022-01-10'),
('Juan', 'Martínez', 'juan.martinez@example.com', '555-1002', 'Av. Siempre Viva 45', 'Barcelona', 'Cataluña', '08001', '2022-03-20'),
('María', 'López', 'maria.lopez@example.com', '555-1003', 'Plaza Mayor 7', 'Valencia', 'C. Valenciana', '46001', '2022-05-01'),
('Pedro', 'Ruiz', 'pedro.ruiz@example.com', '555-1004', 'C/ Sol 1', 'Sevilla', 'Andalucía', '41001', '2022-07-15'),
('Laura', 'Sánchez', 'laura.sanchez@example.com', '555-1005', 'Rambla Cataluña 20', 'Barcelona', 'Cataluña', '08007', '2022-09-01'),
('Carlos', 'Díaz', 'carlos.diaz@example.com', '555-1006', 'Gran Vía 5', 'Madrid', 'Madrid', '28013', '2022-11-11'),
('Sofía', 'Fernández', 'sofia.fdez@example.com', '555-1007', 'C/ Colón 10', 'Valencia', 'C. Valenciana', '46004', '2023-01-05');


-- Categorías de Productos
INSERT INTO product_categories (category_name) VALUES
('Electrónica'),
('Accesorios'),
('Hogar'),
('Libros'),
('Ropa');


-- Productos
INSERT INTO products (product_name, category_id, description, unit_price, product_cost, stock_quantity) VALUES
('Laptop Pro X', (SELECT category_id FROM product_categories WHERE category_name = 'Electrónica'), 'Potente laptop para profesionales.', 1200.50, 850.00, 50),
('Mouse Ergonómico', (SELECT category_id FROM product_categories WHERE category_name = 'Accesorios'), 'Mouse cómodo para uso prolongado.', 25.00, 10.00, 200),
('Teclado Mecánico RGB', (SELECT category_id FROM product_categories WHERE category_name = 'Accesorios'), 'Teclado para gamers con retroiluminación.', 75.00, 30.00, 150),
('Monitor Curvo 27"', (SELECT category_id FROM product_categories WHERE category_name = 'Electrónica'), 'Monitor de alta resolución.', 300.00, 180.00, 70),
('Webcam HD', (SELECT category_id FROM product_categories WHERE category_name = 'Accesorios'), 'Webcam para videollamadas.', 40.00, 15.00, 180),
('Altavoces Bluetooth', (SELECT category_id FROM product_categories WHERE category_name = 'Electrónica'), 'Altavoces inalámbricos de alta calidad.', 80.00, 40.00, 90),
('Libro "Python para Dummies"', (SELECT category_id FROM product_categories WHERE category_name = 'Libros'), 'Guía básica de programación.', 20.00, 8.00, 100),
('Cafetera Programable', (SELECT category_id FROM product_categories WHERE category_name = 'Hogar'), 'Cafetera con temporizador.', 60.00, 25.00, 60),
('Camiseta Algodón', (SELECT category_id FROM product_categories WHERE category_name = 'Ropa'), 'Camiseta 100% algodón.', 15.00, 5.00, 300),
('Disco Duro Externo 1TB', (SELECT category_id FROM product_categories WHERE category_name = 'Electrónica'), 'Almacenamiento portátil.', 70.00, 35.00, 120),
('Mando Gaming', (SELECT category_id FROM product_categories WHERE category_name = 'Accesorios'), 'Mando compatible con PC/Consola.', 50.00, 20.00, 100);


-- Pedidos
INSERT INTO orders (customer_id, order_date, shipped_date, status) VALUES
((SELECT customer_id FROM customers WHERE email = 'ana.garcia@example.com'), '2023-01-10 10:00:00', '2023-01-12 14:30:00', 'Delivered'),
((SELECT customer_id FROM customers WHERE email = 'juan.martinez@example.com'), '2023-01-15 11:30:00', '2023-01-18 09:00:00', 'Delivered'),
((SELECT customer_id FROM customers WHERE email = 'ana.garcia@example.com'), '2023-02-01 14:00:00', '2023-02-03 16:00:00', 'Delivered'),
((SELECT customer_id FROM customers WHERE email = 'maria.lopez@example.com'), '2023-02-10 09:15:00', '2023-02-12 11:45:00', 'Delivered'),
((SELECT customer_id FROM customers WHERE email = 'pedro.ruiz@example.com'), '2023-03-05 16:00:00', '2023-03-08 10:00:00', 'Shipped'),
((SELECT customer_id FROM customers WHERE email = 'laura.sanchez@example.com'), '2023-03-10 12:00:00', NULL, 'Pending'), -- Pedido pendiente
((SELECT customer_id FROM customers WHERE email = 'carlos.diaz@example.com'), '2023-04-01 10:30:00', '2023-04-03 15:00:00', 'Delivered'),
((SELECT customer_id FROM customers WHERE email = 'sofia.fdez@example.com'), '2023-04-10 17:00:00', '2023-04-12 11:00:00', 'Delivered'),
((SELECT customer_id FROM customers WHERE email = 'juan.martinez@example.com'), '2023-05-01 08:00:00', '2023-05-03 13:00:00', 'Delivered'),
((SELECT customer_id FROM customers WHERE email = 'ana.garcia@example.com'), '2023-05-05 13:00:00', '2023-05-07 10:00:00', 'Delivered'),
((SELECT customer_id FROM customers WHERE email = 'laura.sanchez@example.com'), '2023-05-10 11:00:00', '2023-05-12 12:00:00', 'Shipped');


-- Detalles del Pedido
INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES
((SELECT order_id FROM orders WHERE customer_id = (SELECT customer_id FROM customers WHERE email = 'ana.garcia@example.com') AND order_date = '2023-01-10 10:00:00'), (SELECT product_id FROM products WHERE product_name = 'Laptop Pro X'), 1, 1200.50),
((SELECT order_id FROM orders WHERE customer_id = (SELECT customer_id FROM customers WHERE email = 'ana.garcia@example.com') AND order_date = '2023-01-10 10:00:00'), (SELECT product_id FROM products WHERE product_name = 'Mouse Ergonómico'), 1, 25.00),

((SELECT order_id FROM orders WHERE customer_id = (SELECT customer_id FROM customers WHERE email = 'juan.martinez@example.com') AND order_date = '2023-01-15 11:30:00'), (SELECT product_id FROM products WHERE product_name = 'Teclado Mecánico RGB'), 1, 75.00),
((SELECT order_id FROM orders WHERE customer_id = (SELECT customer_id FROM customers WHERE email = 'juan.martinez@example.com') AND order_date = '2023-01-15 11:30:00'), (SELECT product_id FROM products WHERE product_name = 'Webcam HD'), 2, 40.00),

((SELECT order_id FROM orders WHERE customer_id = (SELECT customer_id FROM customers WHERE email = 'ana.garcia@example.com') AND order_date = '2023-02-01 14:00:00'), (SELECT product_id FROM products WHERE product_name = 'Monitor Curvo 27"'), 1, 300.00),

((SELECT order_id FROM orders WHERE customer_id = (SELECT customer_id FROM customers WHERE email = 'maria.lopez@example.com') AND order_date = '2023-02-10 09:15:00'), (SELECT product_id FROM products WHERE product_name = 'Altavoces Bluetooth'), 1, 80.00),
((SELECT order_id FROM orders WHERE customer_id = (SELECT customer_id FROM customers WHERE email = 'maria.lopez@example.com') AND order_date = '2023-02-10 09:15:00'), (SELECT product_id FROM products WHERE product_name = 'Libro "Python para Dummies"'), 2, 20.00),

((SELECT order_id FROM orders WHERE customer_id = (SELECT customer_id FROM customers WHERE email = 'pedro.ruiz@example.com') AND order_date = '2023-03-05 16:00:00'), (SELECT product_id FROM products WHERE product_name = 'Cafetera Programable'), 1, 60.00),

((SELECT order_id FROM orders WHERE customer_id = (SELECT customer_id FROM customers WHERE email = 'laura.sanchez@example.com') AND order_date = '2023-03-10 12:00:00'), (SELECT product_id FROM products WHERE product_name = 'Camiseta Algodón'), 3, 15.00),
((SELECT order_id FROM orders WHERE customer_id = (SELECT customer_id FROM customers WHERE email = 'laura.sanchez@example.com') AND order_date = '2023-03-10 12:00:00'), (SELECT product_id FROM products WHERE product_name = 'Mouse Ergonómico'), 1, 25.00),

((SELECT order_id FROM orders WHERE customer_id = (SELECT customer_id FROM customers WHERE email = 'carlos.diaz@example.com') AND order_date = '2023-04-01 10:30:00'), (SELECT product_id FROM products WHERE product_name = 'Disco Duro Externo 1TB'), 1, 70.00),
((SELECT order_id FROM orders WHERE customer_id = (SELECT customer_id FROM customers WHERE email = 'carlos.diaz@example.com') AND order_date = '2023-04-01 10:30:00'), (SELECT product_id FROM products WHERE product_name = 'Laptop Pro X'), 1, 1200.50),

((SELECT order_id FROM orders WHERE customer_id = (SELECT customer_id FROM customers WHERE email = 'sofia.fdez@example.com') AND order_date = '2023-04-10 17:00:00'), (SELECT product_id FROM products WHERE product_name = 'Mando Gaming'), 2, 50.00),

((SELECT order_id FROM orders WHERE customer_id = (SELECT customer_id FROM customers WHERE email = 'juan.martinez@example.com') AND order_date = '2023-05-01 08:00:00'), (SELECT product_id FROM products WHERE product_name = 'Monitor Curvo 27"'), 1, 300.00),

((SELECT order_id FROM orders WHERE customer_id = (SELECT customer_id FROM customers WHERE email = 'ana.garcia@example.com') AND order_date = '2023-05-05 13:00:00'), (SELECT product_id FROM products WHERE product_name = 'Webcam HD'), 1, 40.00),
((SELECT order_id FROM orders WHERE customer_id = (SELECT customer_id FROM customers WHERE email = 'ana.garcia@example.com') AND order_date = '2023-05-05 13:00:00'), (SELECT product_id FROM products WHERE product_name = 'Teclado Mecánico RGB'), 1, 75.00),

((SELECT order_id FROM orders WHERE customer_id = (SELECT customer_id FROM customers WHERE email = 'laura.sanchez@example.com') AND order_date = '2023-05-10 11:00:00'), (SELECT product_id FROM products WHERE product_name = 'Altavoces Bluetooth'), 1, 80.00);


-- Actualizar total_amount en la tabla orders (suma de los detalles del pedido)
UPDATE orders o
SET total_amount = (
    SELECT SUM(od.quantity * od.unit_price)
    FROM order_details od
    WHERE od.order_id = o.order_id
)
WHERE o.order_id IN (SELECT order_id FROM order_details);

-- Si algún order_id no tiene detalles, su total_amount seguirá siendo NULL.
-- Podemos actualizarlo a 0 o manejarlo según la lógica de negocio.
UPDATE orders
SET total_amount = 0
WHERE total_amount IS NULL;
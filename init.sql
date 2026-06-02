-- Chạy script này trên MySQL VPS trước khi deploy app
-- mysql -h 103.249.117.228 -P 43766 -u root -p < init.sql

CREATE DATABASE IF NOT EXISTS demo_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE demo_db;

-- Table sẽ tự tạo bởi Hibernate (ddl-auto: update)
-- Nhưng nếu muốn tạo thủ công:
CREATE TABLE IF NOT EXISTS employees (
    id          BIGINT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(255) NOT NULL,
    email       VARCHAR(255) NOT NULL UNIQUE,
    department  VARCHAR(100),
    salary      DOUBLE,
    created_at  DATETIME,
    updated_at  DATETIME
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Seed data mẫu
INSERT IGNORE INTO employees (name, email, department, salary, created_at, updated_at) VALUES
('Nguyễn Văn An',   'an.nguyen@demo.com',   'Engineering', 25000000, NOW(), NOW()),
('Trần Thị Bình',   'binh.tran@demo.com',   'HR',          18000000, NOW(), NOW()),
('Lê Quang Cường',  'cuong.le@demo.com',    'Finance',     22000000, NOW(), NOW()),
('Phạm Thị Dung',   'dung.pham@demo.com',   'Engineering', 28000000, NOW(), NOW()),
('Hoàng Văn Em',    'em.hoang@demo.com',    'Marketing',   20000000, NOW(), NOW());

SELECT 'Database initialized successfully!' AS status;
SELECT COUNT(*) AS total_employees FROM employees;

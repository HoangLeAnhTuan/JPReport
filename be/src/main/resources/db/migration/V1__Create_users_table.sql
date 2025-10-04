-- =============================================================================
-- V1__Create_users_table.sql
-- Create users table for authentication and user management
-- =============================================================================

CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    department VARCHAR(100),
    employee_id VARCHAR(50) UNIQUE,
    hire_date DATE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for better performance
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_employee_id ON users(employee_id);
CREATE INDEX idx_users_is_active ON users(is_active);

-- Add comments
COMMENT ON TABLE users IS 'ユーザー管理テーブル - User management table';
COMMENT ON COLUMN users.email IS 'メールアドレス（ログインID）';
COMMENT ON COLUMN users.password IS 'パスワード（BCrypt暗号化）';
COMMENT ON COLUMN users.full_name IS '氏名';
COMMENT ON COLUMN users.phone_number IS '電話番号';
COMMENT ON COLUMN users.department IS '部署名';
COMMENT ON COLUMN users.employee_id IS '社員番号';
COMMENT ON COLUMN users.hire_date IS '入社日';

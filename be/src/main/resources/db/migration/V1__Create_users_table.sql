-- =============================================================================
-- V1__Create_users_table.sql
-- Create users table for authentication and user management
-- =============================================================================

CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    full_name_kana VARCHAR(255),
    role VARCHAR(50) NOT NULL DEFAULT 'EMPLOYEE',
    department VARCHAR(100),
    employee_id VARCHAR(50) UNIQUE,
    hire_date DATE,
    is_active BOOLEAN DEFAULT TRUE,
    
    -- Base Entity Fields
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by BIGINT,
    updated_by BIGINT,
    is_deleted BOOLEAN DEFAULT FALSE,
    version BIGINT DEFAULT 0
);

-- Create indexes for better performance
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_employee_id ON users(employee_id);
CREATE INDEX idx_users_role ON users(role);
CREATE INDEX idx_users_department ON users(department);
CREATE INDEX idx_users_is_deleted ON users(is_deleted);

-- Insert default admin user
INSERT INTO users (
    email, 
    password, 
    full_name, 
    full_name_kana, 
    role, 
    department, 
    employee_id, 
    hire_date,
    created_by,
    updated_by
) VALUES (
    'admin@jpreport.com',
    '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', -- password: password
    'システム管理者',
    'システムカンリシャ',
    'ADMIN',
    'システム部',
    'EMP001',
    CURRENT_DATE,
    1,
    1
);

-- Grant permissions to jpreport user
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO jpreport;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO jpreport;

COMMENT ON TABLE users IS 'ユーザー管理テーブル - User management table';
COMMENT ON COLUMN users.email IS 'メールアドレス（ログインID）';
COMMENT ON COLUMN users.password IS 'パスワード（BCrypt暗号化）';
COMMENT ON COLUMN users.full_name IS '氏名';
COMMENT ON COLUMN users.full_name_kana IS 'フリガナ';
COMMENT ON COLUMN users.role IS '権限（ADMIN, MANAGER, EMPLOYEE）';
COMMENT ON COLUMN users.department IS '部署名';
COMMENT ON COLUMN users.employee_id IS '社員番号';
COMMENT ON COLUMN users.hire_date IS '入社日';

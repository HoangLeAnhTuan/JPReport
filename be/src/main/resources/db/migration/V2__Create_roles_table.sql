-- =============================================================================
-- V2__Create_roles_table.sql
-- Create roles table for role-based access control
-- =============================================================================

CREATE TABLE roles (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes (name already has UNIQUE constraint)

-- Add comments
COMMENT ON TABLE roles IS '役割管理テーブル - Roles management table';
COMMENT ON COLUMN roles.name IS '役割名（ADMIN, MANAGER, EMPLOYEE）';
COMMENT ON COLUMN roles.description IS '役割の説明';

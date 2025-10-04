-- =============================================================================
-- V3__Create_user_roles_table.sql
-- Create user_roles table for N:N relationship between users and roles
-- =============================================================================

CREATE TABLE user_roles (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT REFERENCES users(id) ON DELETE CASCADE,
    role_id BIGINT REFERENCES roles(id) ON DELETE CASCADE,
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, role_id)
);

-- Create indexes for foreign keys
CREATE INDEX idx_user_roles_user_id ON user_roles(user_id);
CREATE INDEX idx_user_roles_role_id ON user_roles(role_id);

-- Add comments
COMMENT ON TABLE user_roles IS 'ユーザー役割関連テーブル - User roles relationship table';
COMMENT ON COLUMN user_roles.user_id IS 'ユーザーID';
COMMENT ON COLUMN user_roles.role_id IS '役割ID';
COMMENT ON COLUMN user_roles.assigned_at IS '役割付与日時';

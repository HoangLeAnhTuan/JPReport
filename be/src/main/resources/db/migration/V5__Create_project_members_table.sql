-- =============================================================================
-- V5__Create_project_members_table.sql
-- Create project_members table for project team management
-- =============================================================================

CREATE TABLE project_members (
    id BIGSERIAL PRIMARY KEY,
    project_id BIGINT REFERENCES projects(id) ON DELETE CASCADE,
    user_id BIGINT REFERENCES users(id) ON DELETE CASCADE,
    role VARCHAR(50) DEFAULT 'MEMBER',
    joined_date DATE DEFAULT CURRENT_DATE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(project_id, user_id)
);

-- Create indexes for foreign keys and common queries
CREATE INDEX idx_project_members_project_id ON project_members(project_id);
CREATE INDEX idx_project_members_user_id ON project_members(user_id);
CREATE INDEX idx_project_members_is_active ON project_members(is_active);

-- Add comments
COMMENT ON TABLE project_members IS 'プロジェクトメンバー管理テーブル - Project members management table';
COMMENT ON COLUMN project_members.project_id IS 'プロジェクトID';
COMMENT ON COLUMN project_members.user_id IS 'ユーザーID';
COMMENT ON COLUMN project_members.role IS 'プロジェクト内役割（LEADER, MEMBER）';
COMMENT ON COLUMN project_members.joined_date IS 'プロジェクト参加日';

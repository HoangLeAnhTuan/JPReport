-- =============================================================================
-- V4__Create_projects_table.sql
-- Create projects table for project management
-- =============================================================================

CREATE TABLE projects (
    id BIGSERIAL PRIMARY KEY,
    code VARCHAR(20) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    status VARCHAR(50) DEFAULT 'ACTIVE',
    start_date DATE,
    end_date DATE,
    manager_id BIGINT REFERENCES users(id),
    budget DECIMAL(12,2),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes (code already has UNIQUE constraint)
CREATE INDEX idx_projects_status ON projects(status);
CREATE INDEX idx_projects_manager_id ON projects(manager_id);
CREATE INDEX idx_projects_is_active ON projects(is_active);

-- Add comments
COMMENT ON TABLE projects IS 'プロジェクト管理テーブル - Projects management table';
COMMENT ON COLUMN projects.code IS 'プロジェクトコード（PRJ-001）';
COMMENT ON COLUMN projects.name IS 'プロジェクト名';
COMMENT ON COLUMN projects.description IS 'プロジェクト説明';
COMMENT ON COLUMN projects.status IS 'プロジェクト状態（ACTIVE, COMPLETED, SUSPENDED）';
COMMENT ON COLUMN projects.manager_id IS 'プロジェクトマネージャーID';
COMMENT ON COLUMN projects.budget IS 'プロジェクト予算';

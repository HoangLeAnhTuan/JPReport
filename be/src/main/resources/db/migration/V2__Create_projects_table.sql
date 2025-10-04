-- =============================================================================
-- V2__Create_projects_table.sql
-- Create projects table for project management
-- =============================================================================

CREATE TABLE projects (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    status VARCHAR(50) DEFAULT 'ACTIVE',
    start_date DATE,
    end_date DATE,
    manager_id BIGINT REFERENCES users(id),
    budget DECIMAL(12,2),
    is_active BOOLEAN DEFAULT TRUE,
    
    -- Base Entity Fields
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by BIGINT,
    updated_by BIGINT,
    is_deleted BOOLEAN DEFAULT FALSE,
    version BIGINT DEFAULT 0
);

-- Create project members table
CREATE TABLE project_members (
    id BIGSERIAL PRIMARY KEY,
    project_id BIGINT REFERENCES projects(id) ON DELETE CASCADE,
    user_id BIGINT REFERENCES users(id) ON DELETE CASCADE,
    role VARCHAR(50) DEFAULT 'MEMBER',
    joined_date DATE DEFAULT CURRENT_DATE,
    is_active BOOLEAN DEFAULT TRUE,
    
    -- Base Entity Fields
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by BIGINT,
    updated_by BIGINT,
    is_deleted BOOLEAN DEFAULT FALSE,
    version BIGINT DEFAULT 0,
    
    UNIQUE(project_id, user_id)
);

-- Create indexes
CREATE INDEX idx_projects_status ON projects(status);
CREATE INDEX idx_projects_manager_id ON projects(manager_id);
CREATE INDEX idx_projects_is_deleted ON projects(is_deleted);
CREATE INDEX idx_project_members_project_id ON project_members(project_id);
CREATE INDEX idx_project_members_user_id ON project_members(user_id);

-- Insert sample projects
INSERT INTO projects (
    name, 
    description, 
    status, 
    start_date, 
    end_date, 
    manager_id,
    budget,
    created_by,
    updated_by
) VALUES 
(
    '日報管理システム開発',
    '社員の日報作成・管理・承認を行うWebシステムの開発',
    'ACTIVE',
    '2024-01-01',
    '2024-12-31',
    1,
    5000000.00,
    1,
    1
),
(
    'システム保守・運用',
    '既存システムの保守・運用業務',
    'ACTIVE',
    '2024-01-01',
    NULL,
    1,
    2000000.00,
    1,
    1
);

COMMENT ON TABLE projects IS 'プロジェクト管理テーブル';
COMMENT ON TABLE project_members IS 'プロジェクトメンバー管理テーブル';
COMMENT ON COLUMN projects.status IS 'プロジェクト状態（ACTIVE, COMPLETED, SUSPENDED）';
COMMENT ON COLUMN project_members.role IS 'プロジェクト内役割（LEADER, MEMBER）';

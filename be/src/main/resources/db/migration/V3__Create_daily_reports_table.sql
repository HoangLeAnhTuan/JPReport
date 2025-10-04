-- =============================================================================
-- V3__Create_daily_reports_table.sql
-- Create daily reports and related tables
-- =============================================================================

-- Daily Reports Table
CREATE TABLE daily_reports (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT REFERENCES users(id) ON DELETE CASCADE,
    report_date DATE NOT NULL,
    work_start_time TIME,
    work_end_time TIME,
    break_minutes INTEGER DEFAULT 60,
    work_summary TEXT NOT NULL,
    issues TEXT,
    next_day_plan TEXT,
    status VARCHAR(50) DEFAULT 'DRAFT',
    submitted_at TIMESTAMP,
    approved_by BIGINT REFERENCES users(id),
    approved_at TIMESTAMP,
    
    -- Base Entity Fields
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by BIGINT,
    updated_by BIGINT,
    is_deleted BOOLEAN DEFAULT FALSE,
    version BIGINT DEFAULT 0,
    
    UNIQUE(user_id, report_date)
);

-- Report Tasks Table
CREATE TABLE report_tasks (
    id BIGSERIAL PRIMARY KEY,
    daily_report_id BIGINT REFERENCES daily_reports(id) ON DELETE CASCADE,
    project_id BIGINT REFERENCES projects(id),
    task_name VARCHAR(255) NOT NULL,
    description TEXT,
    work_hours DECIMAL(4,2) NOT NULL,
    progress_rate INTEGER DEFAULT 0,
    priority VARCHAR(20) DEFAULT 'MEDIUM',
    is_completed BOOLEAN DEFAULT FALSE,
    
    -- Base Entity Fields
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by BIGINT,
    updated_by BIGINT,
    is_deleted BOOLEAN DEFAULT FALSE,
    version BIGINT DEFAULT 0
);

-- Attendance Table
CREATE TABLE attendance (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT REFERENCES users(id) ON DELETE CASCADE,
    attendance_date DATE NOT NULL,
    clock_in_time TIMESTAMP,
    clock_out_time TIMESTAMP,
    break_start_time TIMESTAMP,
    break_end_time TIMESTAMP,
    work_type VARCHAR(50) DEFAULT 'OFFICE',
    overtime_hours DECIMAL(4,2) DEFAULT 0,
    notes TEXT,
    
    -- Base Entity Fields
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by BIGINT,
    updated_by BIGINT,
    is_deleted BOOLEAN DEFAULT FALSE,
    version BIGINT DEFAULT 0,
    
    UNIQUE(user_id, attendance_date)
);

-- Tags Table
CREATE TABLE tags (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    color VARCHAR(7) DEFAULT '#007bff',
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    
    -- Base Entity Fields
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by BIGINT,
    updated_by BIGINT,
    is_deleted BOOLEAN DEFAULT FALSE,
    version BIGINT DEFAULT 0
);

-- Report Tags Junction Table
CREATE TABLE report_tags (
    id BIGSERIAL PRIMARY KEY,
    daily_report_id BIGINT REFERENCES daily_reports(id) ON DELETE CASCADE,
    tag_id BIGINT REFERENCES tags(id) ON DELETE CASCADE,
    
    -- Base Entity Fields
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by BIGINT,
    updated_by BIGINT,
    is_deleted BOOLEAN DEFAULT FALSE,
    version BIGINT DEFAULT 0,
    
    UNIQUE(daily_report_id, tag_id)
);

-- Create indexes
CREATE INDEX idx_daily_reports_user_id ON daily_reports(user_id);
CREATE INDEX idx_daily_reports_report_date ON daily_reports(report_date);
CREATE INDEX idx_daily_reports_status ON daily_reports(status);
CREATE INDEX idx_daily_reports_is_deleted ON daily_reports(is_deleted);

CREATE INDEX idx_report_tasks_daily_report_id ON report_tasks(daily_report_id);
CREATE INDEX idx_report_tasks_project_id ON report_tasks(project_id);
CREATE INDEX idx_report_tasks_is_deleted ON report_tasks(is_deleted);

CREATE INDEX idx_attendance_user_id ON attendance(user_id);
CREATE INDEX idx_attendance_date ON attendance(attendance_date);
CREATE INDEX idx_attendance_is_deleted ON attendance(is_deleted);

CREATE INDEX idx_tags_name ON tags(name);
CREATE INDEX idx_tags_is_active ON tags(is_active);

CREATE INDEX idx_report_tags_daily_report_id ON report_tags(daily_report_id);
CREATE INDEX idx_report_tags_tag_id ON report_tags(tag_id);

-- Insert sample tags
INSERT INTO tags (name, color, description, created_by, updated_by) VALUES
('開発', '#28a745', '開発作業関連', 1, 1),
('会議', '#17a2b8', '会議・打ち合わせ', 1, 1),
('調査', '#ffc107', '調査・研究作業', 1, 1),
('テスト', '#dc3545', 'テスト・検証作業', 1, 1),
('ドキュメント', '#6f42c1', 'ドキュメント作成', 1, 1),
('保守', '#fd7e14', 'システム保守・運用', 1, 1);

COMMENT ON TABLE daily_reports IS '日報管理テーブル';
COMMENT ON TABLE report_tasks IS '日報タスク詳細テーブル';
COMMENT ON TABLE attendance IS '勤怠管理テーブル';
COMMENT ON TABLE tags IS 'タグ管理テーブル';
COMMENT ON TABLE report_tags IS '日報タグ関連テーブル';

COMMENT ON COLUMN daily_reports.status IS '日報状態（DRAFT, SUBMITTED, APPROVED）';
COMMENT ON COLUMN report_tasks.priority IS 'タスク優先度（HIGH, MEDIUM, LOW）';
COMMENT ON COLUMN attendance.work_type IS '勤務形態（OFFICE, REMOTE, HOLIDAY）';

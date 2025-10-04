-- =============================================================================
-- V7__Create_report_tasks_table.sql
-- Create report_tasks table for detailed task breakdown in daily reports
-- =============================================================================

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
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for foreign keys
CREATE INDEX idx_report_tasks_daily_report_id ON report_tasks(daily_report_id);
CREATE INDEX idx_report_tasks_project_id ON report_tasks(project_id);

-- Add comments
COMMENT ON TABLE report_tasks IS '日報タスク詳細テーブル - Report tasks detail table';
COMMENT ON COLUMN report_tasks.daily_report_id IS '日報ID';
COMMENT ON COLUMN report_tasks.project_id IS 'プロジェクトID';
COMMENT ON COLUMN report_tasks.task_name IS 'タスク名';
COMMENT ON COLUMN report_tasks.description IS 'タスク説明';
COMMENT ON COLUMN report_tasks.work_hours IS '作業時間';
COMMENT ON COLUMN report_tasks.progress_rate IS '進捗率（0-100）';
COMMENT ON COLUMN report_tasks.priority IS 'タスク優先度（HIGH, MEDIUM, LOW）';
COMMENT ON COLUMN report_tasks.is_completed IS 'タスク完了フラグ';

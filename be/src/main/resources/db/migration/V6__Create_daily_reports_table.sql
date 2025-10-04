-- =============================================================================
-- V6__Create_daily_reports_table.sql
-- Create daily_reports table for daily work reports
-- =============================================================================

CREATE TABLE daily_reports (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT REFERENCES users(id),
    project_id BIGINT REFERENCES projects(id),
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
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, report_date)
);

-- Create indexes for common queries
CREATE INDEX idx_daily_reports_user_id ON daily_reports(user_id);
CREATE INDEX idx_daily_reports_report_date ON daily_reports(report_date);
CREATE INDEX idx_daily_reports_status ON daily_reports(status);
CREATE INDEX idx_daily_reports_user_date ON daily_reports(user_id, report_date);

-- Add comments
COMMENT ON TABLE daily_reports IS '日報管理テーブル - Daily reports management table';
COMMENT ON COLUMN daily_reports.user_id IS '報告者ユーザーID';
COMMENT ON COLUMN daily_reports.project_id IS 'メインプロジェクトID';
COMMENT ON COLUMN daily_reports.report_date IS '報告日';
COMMENT ON COLUMN daily_reports.work_start_time IS '作業開始時刻';
COMMENT ON COLUMN daily_reports.work_end_time IS '作業終了時刻';
COMMENT ON COLUMN daily_reports.break_minutes IS '休憩時間（分）';
COMMENT ON COLUMN daily_reports.work_summary IS '作業内容';
COMMENT ON COLUMN daily_reports.issues IS '課題・問題点';
COMMENT ON COLUMN daily_reports.next_day_plan IS '翌日予定';
COMMENT ON COLUMN daily_reports.status IS '日報状態（DRAFT, SUBMITTED, APPROVED, REJECTED）';

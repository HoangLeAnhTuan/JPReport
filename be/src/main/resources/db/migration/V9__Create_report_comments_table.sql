-- =============================================================================
-- V9__Create_report_comments_table.sql
-- Create report_comments table for manager feedback on daily reports
-- =============================================================================

CREATE TABLE report_comments (
    id BIGSERIAL PRIMARY KEY,
    daily_report_id BIGINT REFERENCES daily_reports(id) ON DELETE CASCADE,
    user_id BIGINT REFERENCES users(id),
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for foreign keys
CREATE INDEX idx_report_comments_daily_report_id ON report_comments(daily_report_id);
CREATE INDEX idx_report_comments_user_id ON report_comments(user_id);

-- Add comments
COMMENT ON TABLE report_comments IS '日報コメント管理テーブル - Report comments management table';
COMMENT ON COLUMN report_comments.daily_report_id IS '日報ID';
COMMENT ON COLUMN report_comments.user_id IS 'コメント投稿者ID';
COMMENT ON COLUMN report_comments.content IS 'コメント内容';

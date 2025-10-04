-- =============================================================================
-- V8__Create_attendance_table.sql
-- Create attendance table for time tracking and attendance management
-- =============================================================================

CREATE TABLE attendance (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT REFERENCES users(id),
    daily_report_id BIGINT REFERENCES daily_reports(id),
    attendance_date DATE NOT NULL,
    clock_in_time TIMESTAMP,
    clock_out_time TIMESTAMP,
    break_start_time TIMESTAMP,
    break_end_time TIMESTAMP,
    work_type VARCHAR(50) DEFAULT 'OFFICE',
    status VARCHAR(50) DEFAULT 'PRESENT',
    overtime_hours DECIMAL(4,2) DEFAULT 0,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, attendance_date)
);

-- Create indexes for common queries
CREATE INDEX idx_attendance_user_id ON attendance(user_id);
CREATE INDEX idx_attendance_date ON attendance(attendance_date);
CREATE INDEX idx_attendance_user_date ON attendance(user_id, attendance_date);

-- Add comments
COMMENT ON TABLE attendance IS '勤怠管理テーブル - Attendance management table';
COMMENT ON COLUMN attendance.user_id IS 'ユーザーID';
COMMENT ON COLUMN attendance.daily_report_id IS '日報ID（関連付け）';
COMMENT ON COLUMN attendance.attendance_date IS '勤怠日';
COMMENT ON COLUMN attendance.clock_in_time IS '出勤時刻';
COMMENT ON COLUMN attendance.clock_out_time IS '退勤時刻';
COMMENT ON COLUMN attendance.break_start_time IS '休憩開始時刻';
COMMENT ON COLUMN attendance.break_end_time IS '休憩終了時刻';
COMMENT ON COLUMN attendance.work_type IS '勤務形態（OFFICE, REMOTE, HOLIDAY）';
COMMENT ON COLUMN attendance.status IS '勤怠状態（PRESENT, ABSENT, LEAVE）';
COMMENT ON COLUMN attendance.overtime_hours IS '残業時間';
COMMENT ON COLUMN attendance.notes IS '備考';

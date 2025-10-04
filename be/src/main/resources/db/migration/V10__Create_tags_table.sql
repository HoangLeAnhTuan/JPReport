-- =============================================================================
-- V10__Create_tags_table.sql
-- Create tags table for categorization and labeling
-- =============================================================================

CREATE TABLE tags (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    color VARCHAR(7) DEFAULT '#007bff',
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes (name already has UNIQUE constraint)
CREATE INDEX idx_tags_is_active ON tags(is_active);

-- Add comments
COMMENT ON TABLE tags IS 'タグ管理テーブル - Tags management table';
COMMENT ON COLUMN tags.name IS 'タグ名';
COMMENT ON COLUMN tags.color IS 'タグ色（HEXカラーコード）';
COMMENT ON COLUMN tags.description IS 'タグ説明';
COMMENT ON COLUMN tags.is_active IS 'アクティブフラグ';

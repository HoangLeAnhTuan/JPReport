-- =============================================================================
-- V11__Create_tag_relations_table.sql
-- Create tag_relations table for flexible tagging system
-- =============================================================================

CREATE TABLE tag_relations (
    id BIGSERIAL PRIMARY KEY,
    tag_id BIGINT REFERENCES tags(id) ON DELETE CASCADE,
    target_id BIGINT NOT NULL,
    target_type VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(tag_id, target_id, target_type)
);

-- Create indexes for common queries
CREATE INDEX idx_tag_relations_tag_id ON tag_relations(tag_id);
CREATE INDEX idx_tag_relations_target_id_type ON tag_relations(target_id, target_type);

-- Add comments
COMMENT ON TABLE tag_relations IS 'タグ関連テーブル - Tag relations table';
COMMENT ON COLUMN tag_relations.tag_id IS 'タグID';
COMMENT ON COLUMN tag_relations.target_id IS '対象オブジェクトID';
COMMENT ON COLUMN tag_relations.target_type IS '対象オブジェクトタイプ（daily_report, project, task）';

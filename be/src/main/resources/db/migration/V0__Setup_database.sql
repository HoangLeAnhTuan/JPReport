-- =============================================================================
-- V0__Setup_database.sql
-- Initial database setup and permissions
-- =============================================================================

-- This migration runs first to set up basic database structure
-- Note: User 'jpreport' should already exist (created by Docker environment)

-- Ensure proper permissions for jpreport user
-- (These commands might need superuser privileges, so they're here for reference)
-- GRANT ALL PRIVILEGES ON DATABASE jpreport_db TO jpreport;
-- GRANT ALL ON SCHEMA public TO jpreport;

-- Create extensions if needed
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Set timezone
SET timezone = 'Asia/Singapore';

COMMENT ON SCHEMA public IS 'JP Report System - Main Schema';

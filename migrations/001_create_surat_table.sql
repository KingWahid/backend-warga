-- Migration: Create surat table
-- Created: 2024-01-01

CREATE TABLE IF NOT EXISTS surat (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nama VARCHAR(255) NOT NULL,
    deskripsi TEXT NOT NULL,
    template TEXT NOT NULL,
    required_fields JSON NOT NULL,
    kategori VARCHAR(100) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    deleted_at TIMESTAMP WITH TIME ZONE
);

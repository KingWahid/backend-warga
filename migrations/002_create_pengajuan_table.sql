-- Migration: Create pengajuan table
-- Created: 2024-01-01

CREATE TABLE IF NOT EXISTS pengajuan (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    surat_id UUID NOT NULL REFERENCES surat(id),
    warga_id UUID NOT NULL REFERENCES warga(id),
    status VARCHAR(50) NOT NULL DEFAULT 'pending',
    alasan TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    deleted_at TIMESTAMP WITH TIME ZONE,
    approved_by VARCHAR(255),
    approved_at TIMESTAMP WITH TIME ZONE,
    rejected_by VARCHAR(255),
    rejected_at TIMESTAMP WITH TIME ZONE,
    notes TEXT
);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_pengajuan_surat_id ON pengajuan(surat_id);
CREATE INDEX IF NOT EXISTS idx_pengajuan_warga_id ON pengajuan(warga_id);
CREATE INDEX IF NOT EXISTS idx_pengajuan_status ON pengajuan(status);
CREATE INDEX IF NOT EXISTS idx_pengajuan_created_at ON pengajuan(created_at); 
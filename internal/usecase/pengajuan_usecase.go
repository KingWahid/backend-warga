package usecase

import (
	"backend-warga/internal/model"
	"backend-warga/internal/repository"
	"context"

	"github.com/google/uuid"
)

type PengajuanUseCase interface {
	CreatePengajuan(pengajuan *model.Pengajuan) error
	GetPengajuanByID(id string) (*model.Pengajuan, error)
	GetAllPengajuan() ([]model.Pengajuan, error)
	GetPengajuanByWargaID(wargaID string) ([]model.Pengajuan, error)
	GetPengajuanByStatus(status string) ([]model.Pengajuan, error)
	UpdatePengajuan(pengajuan *model.Pengajuan) error
	DeletePengajuan(id string) error
	ApprovePengajuan(id string, approvedBy string) error
	RejectPengajuan(id string, rejectedBy string, reason string) error
	GetByRTID(ctx context.Context, rtID int) ([]*model.Pengajuan, error)
	ApproveByRT(ctx context.Context, id string, ttdRTUrl string) error
	RejectByRT(ctx context.Context, id string) error
	GetByID(ctx context.Context, id uuid.UUID) (*model.Pengajuan, error)
}

type pengajuanUseCase struct {
	repo repository.PengajuanRepository
}

func NewPengajuanUseCase(repo repository.PengajuanRepository) PengajuanUseCase {
	return &pengajuanUseCase{repo: repo}
}

func (uc *pengajuanUseCase) CreatePengajuan(pengajuan *model.Pengajuan) error {
	return uc.repo.Create(pengajuan)
}

func (uc *pengajuanUseCase) GetPengajuanByID(id string) (*model.Pengajuan, error) {
	return uc.repo.FindByID(id)
}

func (uc *pengajuanUseCase) GetAllPengajuan() ([]model.Pengajuan, error) {
	return uc.repo.FindAll()
}

func (uc *pengajuanUseCase) GetPengajuanByWargaID(wargaID string) ([]model.Pengajuan, error) {
	return uc.repo.FindByWargaID(wargaID)
}

func (uc *pengajuanUseCase) GetPengajuanByStatus(status string) ([]model.Pengajuan, error) {
	return uc.repo.FindByStatus(status)
}

func (uc *pengajuanUseCase) UpdatePengajuan(pengajuan *model.Pengajuan) error {
	return uc.repo.Update(pengajuan)
}

func (uc *pengajuanUseCase) DeletePengajuan(id string) error {
	return uc.repo.Delete(id)
}

func (uc *pengajuanUseCase) ApprovePengajuan(id string, approvedBy string) error {
	return uc.repo.Approve(id, approvedBy)
}

func (uc *pengajuanUseCase) RejectPengajuan(id string, rejectedBy string, reason string) error {
	return uc.repo.Reject(id, rejectedBy, reason)
}

func (u *pengajuanUseCase) GetByRTID(ctx context.Context, rtID int) ([]*model.Pengajuan, error) {
	return u.repo.GetByRTID(ctx, rtID)
}

func (u *pengajuanUseCase) ApproveByRT(ctx context.Context, id string, ttdRTUrl string) error {
	return u.repo.ApproveByRT(ctx, id, ttdRTUrl)
}

func (u *pengajuanUseCase) RejectByRT(ctx context.Context, id string) error {
	return u.repo.RejectByRT(ctx, id)
}

func (u *pengajuanUseCase) GetByID(ctx context.Context, id uuid.UUID) (*model.Pengajuan, error) {
	return u.repo.FindByIDWithContext(ctx, id)
}

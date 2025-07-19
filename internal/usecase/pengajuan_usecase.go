package usecase

import (
	"backend-warga/internal/model"
	"backend-warga/internal/repository"
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
}

type pengajuanUseCase struct {
	pengajuanRepository repository.PengajuanRepository
}

func NewPengajuanUseCase(pengajuanRepository repository.PengajuanRepository) PengajuanUseCase {
	return &pengajuanUseCase{
		pengajuanRepository: pengajuanRepository,
	}
}

func (uc *pengajuanUseCase) CreatePengajuan(pengajuan *model.Pengajuan) error {
	return uc.pengajuanRepository.Create(pengajuan)
}

func (uc *pengajuanUseCase) GetPengajuanByID(id string) (*model.Pengajuan, error) {
	return uc.pengajuanRepository.FindByID(id)
}

func (uc *pengajuanUseCase) GetAllPengajuan() ([]model.Pengajuan, error) {
	return uc.pengajuanRepository.FindAll()
}

func (uc *pengajuanUseCase) GetPengajuanByWargaID(wargaID string) ([]model.Pengajuan, error) {
	return uc.pengajuanRepository.FindByWargaID(wargaID)
}

func (uc *pengajuanUseCase) GetPengajuanByStatus(status string) ([]model.Pengajuan, error) {
	return uc.pengajuanRepository.FindByStatus(status)
}

func (uc *pengajuanUseCase) UpdatePengajuan(pengajuan *model.Pengajuan) error {
	return uc.pengajuanRepository.Update(pengajuan)
}

func (uc *pengajuanUseCase) DeletePengajuan(id string) error {
	return uc.pengajuanRepository.Delete(id)
}

func (uc *pengajuanUseCase) ApprovePengajuan(id string, approvedBy string) error {
	return uc.pengajuanRepository.Approve(id, approvedBy)
}

func (uc *pengajuanUseCase) RejectPengajuan(id string, rejectedBy string, reason string) error {
	return uc.pengajuanRepository.Reject(id, rejectedBy, reason)
} 
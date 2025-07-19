package usecase

import (
	"backend-warga/internal/model"
	"backend-warga/internal/repository"
)

type SuratUseCase interface {
	CreateSurat(surat *model.Surat) error
	GetSuratByID(id string) (*model.Surat, error)
	GetAllSurat() ([]model.Surat, error)
	UpdateSurat(surat *model.Surat) error
	DeleteSurat(id string) error
}

type suratUseCase struct {
	suratRepository repository.SuratRepository
}

func NewSuratUseCase(suratRepository repository.SuratRepository) SuratUseCase {
	return &suratUseCase{
		suratRepository: suratRepository,
	}
}

func (uc *suratUseCase) CreateSurat(surat *model.Surat) error {
	return uc.suratRepository.Create(surat)
}

func (uc *suratUseCase) GetSuratByID(id string) (*model.Surat, error) {
	return uc.suratRepository.FindByID(id)
}

func (uc *suratUseCase) GetAllSurat() ([]model.Surat, error) {
	return uc.suratRepository.FindAll()
}

func (uc *suratUseCase) UpdateSurat(surat *model.Surat) error {
	return uc.suratRepository.Update(surat)
}

func (uc *suratUseCase) DeleteSurat(id string) error {
	return uc.suratRepository.Delete(id)
}

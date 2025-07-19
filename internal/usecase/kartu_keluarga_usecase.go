package usecase

import (
	"context"
	"fmt"
	"time"

	"github.com/google/uuid"
	"backend-warga/internal/model"
	"backend-warga/internal/repository"
)

type KartuKeluargaUsecase struct {
	repo repository.KartuKeluargaRepository
}

func NewKartuKeluargaUsecase(repo repository.KartuKeluargaRepository) *KartuKeluargaUsecase {
	return &KartuKeluargaUsecase{repo: repo}
}

func (u *KartuKeluargaUsecase) Create(ctx context.Context, req *model.CreateKartuKeluargaRequest) (*model.KartuKeluarga, error) {
	// Validasi No KK harus unik
	existingKK, err := u.repo.GetByNoKK(ctx, req.NoKK)
	if err != nil {
		return nil, fmt.Errorf("error checking existing kartu keluarga: %w", err)
	}
	if existingKK != nil {
		return nil, fmt.Errorf("nomor kartu keluarga sudah terdaftar")
	}

	// Buat kartu keluarga baru
	kk := &model.KartuKeluarga{
		ID:              uuid.New(),
		NoKK:            req.NoKK,
		KepalaKeluargaID: req.KepalaKeluargaID,
		ProvinsiID:      req.ProvinsiID,
		KotaID:          req.KotaID,
		KecamatanID:     req.KecamatanID,
		KelurahanID:     req.KelurahanID,
		RTID:            req.RTID,
		RWID:            req.RWID,
		Alamat:          req.Alamat,
		KodePos:         req.KodePos,
		CreatedAt:       time.Now(),
		UpdatedAt:       time.Now(),
	}

	err = u.repo.Create(ctx, kk)
	if err != nil {
		return nil, fmt.Errorf("error creating kartu keluarga: %w", err)
	}

	return kk, nil
}

func (u *KartuKeluargaUsecase) GetByID(ctx context.Context, id uuid.UUID) (*model.KartuKeluarga, error) {
	kk, err := u.repo.GetByID(ctx, id)
	if err != nil {
		return nil, fmt.Errorf("error getting kartu keluarga: %w", err)
	}
	if kk == nil {
		return nil, fmt.Errorf("kartu keluarga tidak ditemukan")
	}
	return kk, nil
}

func (u *KartuKeluargaUsecase) GetByNoKK(ctx context.Context, noKK string) (*model.KartuKeluarga, error) {
	kk, err := u.repo.GetByNoKK(ctx, noKK)
	if err != nil {
		return nil, fmt.Errorf("error getting kartu keluarga: %w", err)
	}
	if kk == nil {
		return nil, fmt.Errorf("kartu keluarga tidak ditemukan")
	}
	return kk, nil
}

func (u *KartuKeluargaUsecase) GetAll(ctx context.Context) ([]*model.KartuKeluarga, error) {
	kartuKeluargas, err := u.repo.GetAll(ctx)
	if err != nil {
		return nil, fmt.Errorf("error getting all kartu keluarga: %w", err)
	}
	return kartuKeluargas, nil
}

func (u *KartuKeluargaUsecase) Update(ctx context.Context, id uuid.UUID, req *model.UpdateKartuKeluargaRequest) (*model.KartuKeluarga, error) {
	// Ambil data yang ada
	existingKK, err := u.repo.GetByID(ctx, id)
	if err != nil {
		return nil, fmt.Errorf("error getting existing kartu keluarga: %w", err)
	}
	if existingKK == nil {
		return nil, fmt.Errorf("kartu keluarga tidak ditemukan")
	}

	// Update field yang ada di request
	if req.NoKK != "" {
		// Validasi No KK harus unik jika berubah
		if req.NoKK != existingKK.NoKK {
			existingByNoKK, err := u.repo.GetByNoKK(ctx, req.NoKK)
			if err != nil {
				return nil, fmt.Errorf("error checking existing kartu keluarga: %w", err)
			}
			if existingByNoKK != nil {
				return nil, fmt.Errorf("nomor kartu keluarga sudah terdaftar")
			}
		}
		existingKK.NoKK = req.NoKK
	}

	if req.KepalaKeluargaID != nil {
		existingKK.KepalaKeluargaID = req.KepalaKeluargaID
	}

	if req.ProvinsiID != 0 {
		existingKK.ProvinsiID = req.ProvinsiID
	}

	if req.KotaID != 0 {
		existingKK.KotaID = req.KotaID
	}

	if req.KecamatanID != 0 {
		existingKK.KecamatanID = req.KecamatanID
	}

	if req.KelurahanID != 0 {
		existingKK.KelurahanID = req.KelurahanID
	}

	if req.RTID != 0 {
		existingKK.RTID = req.RTID
	}

	if req.RWID != 0 {
		existingKK.RWID = req.RWID
	}

	if req.Alamat != "" {
		existingKK.Alamat = req.Alamat
	}

	if req.KodePos != "" {
		existingKK.KodePos = req.KodePos
	}

	existingKK.UpdatedAt = time.Now()

	err = u.repo.Update(ctx, existingKK)
	if err != nil {
		return nil, fmt.Errorf("error updating kartu keluarga: %w", err)
	}

	return existingKK, nil
}

func (u *KartuKeluargaUsecase) Delete(ctx context.Context, id uuid.UUID) error {
	// Cek apakah kartu keluarga ada
	existingKK, err := u.repo.GetByID(ctx, id)
	if err != nil {
		return fmt.Errorf("error checking existing kartu keluarga: %w", err)
	}
	if existingKK == nil {
		return fmt.Errorf("kartu keluarga tidak ditemukan")
	}

	err = u.repo.Delete(ctx, id)
	if err != nil {
		return fmt.Errorf("error deleting kartu keluarga: %w", err)
	}

	return nil
} 
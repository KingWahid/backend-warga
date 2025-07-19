package usecase

import (
	"context"
	"fmt"
	"time"

	"backend-warga/internal/model"
	"backend-warga/internal/repository"

	"github.com/google/uuid"
)

type WargaUsecase struct {
	repo     repository.WargaRepository
	kkRepo   repository.KartuKeluargaRepository
	userRepo repository.UserRepository
}

func NewWargaUsecase(repo repository.WargaRepository, kkRepo repository.KartuKeluargaRepository, userRepo repository.UserRepository) *WargaUsecase {
	return &WargaUsecase{repo: repo, kkRepo: kkRepo, userRepo: userRepo}
}

func (u *WargaUsecase) Create(ctx context.Context, req *model.CreateWargaRequest) (*model.Warga, error) {
	// Validasi NIK harus unik
	existingWarga, err := u.repo.GetByNIK(ctx, req.NIK)
	if err != nil {
		return nil, fmt.Errorf("error checking existing warga: %w", err)
	}
	if existingWarga != nil {
		return nil, fmt.Errorf("NIK sudah terdaftar")
	}

	// Validasi kartu keluarga harus ada
	existingKK, err := u.kkRepo.GetByNoKK(ctx, req.NoKK)
	if err != nil {
		return nil, fmt.Errorf("error checking kartu keluarga: %w", err)
	}
	if existingKK == nil {
		return nil, fmt.Errorf("kartu keluarga dengan nomor %s tidak ditemukan", req.NoKK)
	}

	// Validasi jika status keluarga adalah kepala keluarga, cek apakah sudah ada kepala keluarga
	if req.StatusKeluarga == model.StatusKeluargaKepalaKeluarga {
		existingKepalaKeluarga, err := u.repo.GetKepalaKeluargaByNoKK(ctx, req.NoKK)
		if err != nil {
			return nil, fmt.Errorf("error checking kepala keluarga: %w", err)
		}
		if existingKepalaKeluarga != nil {
			return nil, fmt.Errorf("sudah ada kepala keluarga untuk kartu keluarga ini")
		}
	}

	// Parse tanggal lahir
	tanggalLahir, err := time.Parse("2006-01-02", req.TanggalLahir)
	if err != nil {
		return nil, fmt.Errorf("format tanggal lahir tidak valid: %w", err)
	}

	// Parse tanggal perkawinan jika ada
	var tanggalPerkawinan *time.Time
	if req.TanggalPerkawinan != nil && *req.TanggalPerkawinan != "" {
		parsedDate, err := time.Parse("2006-01-02", *req.TanggalPerkawinan)
		if err != nil {
			return nil, fmt.Errorf("format tanggal perkawinan tidak valid: %w", err)
		}
		tanggalPerkawinan = &parsedDate
	}

	// Buat warga baru
	warga := &model.Warga{
		ID:                uuid.New(),
		NamaLengkap:       req.NamaLengkap,
		NIK:               req.NIK,
		NoKK:              req.NoKK,
		TempatLahir:       req.TempatLahir,
		TanggalLahir:      tanggalLahir,
		JenisKelamin:      req.JenisKelamin,
		Agama:             req.Agama,
		Pendidikan:        req.Pendidikan,
		JenisPekerjaan:    req.JenisPekerjaan,
		GolonganDarah:     req.GolonganDarah,
		StatusPerkawinan:  req.StatusPerkawinan,
		TanggalPerkawinan: tanggalPerkawinan,
		StatusKeluarga:    req.StatusKeluarga,
		Kewarganegaraan:   req.Kewarganegaraan,
		NamaAyah:          req.NamaAyah,
		NamaIbu:           req.NamaIbu,
		CreatedAt:         time.Now(),
		UpdatedAt:         time.Now(),
	}

	err = u.repo.Create(ctx, warga)
	if err != nil {
		return nil, fmt.Errorf("error creating warga: %w", err)
	}

	// Jika warga adalah kepala keluarga, update kartu keluarga
	if req.StatusKeluarga == model.StatusKeluargaKepalaKeluarga {
		existingKK.KepalaKeluargaID = &warga.ID
		err = u.kkRepo.Update(ctx, existingKK)
		if err != nil {
			return nil, fmt.Errorf("error updating kartu keluarga: %w", err)
		}
	}

	return warga, nil
}

func (u *WargaUsecase) GetByID(ctx context.Context, id uuid.UUID) (*model.Warga, error) {
	warga, err := u.repo.GetByID(ctx, id)
	if err != nil {
		return nil, fmt.Errorf("error getting warga: %w", err)
	}
	if warga == nil {
		return nil, fmt.Errorf("warga tidak ditemukan")
	}
	return warga, nil
}

func (u *WargaUsecase) GetByNIK(ctx context.Context, nik string) (*model.Warga, error) {
	warga, err := u.repo.GetByNIK(ctx, nik)
	if err != nil {
		return nil, fmt.Errorf("error getting warga: %w", err)
	}
	if warga == nil {
		return nil, fmt.Errorf("warga tidak ditemukan")
	}
	return warga, nil
}

func (u *WargaUsecase) GetByNoKK(ctx context.Context, noKK string) ([]*model.Warga, error) {
	wargas, err := u.repo.GetByNoKK(ctx, noKK)
	if err != nil {
		return nil, fmt.Errorf("error getting warga: %w", err)
	}
	return wargas, nil
}

func (u *WargaUsecase) GetAll(ctx context.Context) ([]*model.Warga, error) {
	wargas, err := u.repo.GetAll(ctx)
	if err != nil {
		return nil, fmt.Errorf("error getting all warga: %w", err)
	}
	return wargas, nil
}

func (u *WargaUsecase) Update(ctx context.Context, id uuid.UUID, req *model.UpdateWargaRequest) (*model.Warga, error) {
	// Ambil data yang ada
	existingWarga, err := u.repo.GetByID(ctx, id)
	if err != nil {
		return nil, fmt.Errorf("error getting existing warga: %w", err)
	}
	if existingWarga == nil {
		return nil, fmt.Errorf("warga tidak ditemukan")
	}

	// Update field yang ada di request
	if req.NamaLengkap != "" {
		existingWarga.NamaLengkap = req.NamaLengkap
	}

	if req.NIK != "" {
		// Validasi NIK harus unik jika berubah
		if req.NIK != existingWarga.NIK {
			existingByNIK, err := u.repo.GetByNIK(ctx, req.NIK)
			if err != nil {
				return nil, fmt.Errorf("error checking existing warga: %w", err)
			}
			if existingByNIK != nil {
				return nil, fmt.Errorf("NIK sudah terdaftar")
			}
		}
		existingWarga.NIK = req.NIK
	}

	if req.NoKK != "" {
		// Validasi kartu keluarga harus ada
		existingKK, err := u.kkRepo.GetByNoKK(ctx, req.NoKK)
		if err != nil {
			return nil, fmt.Errorf("error checking kartu keluarga: %w", err)
		}
		if existingKK == nil {
			return nil, fmt.Errorf("kartu keluarga dengan nomor %s tidak ditemukan", req.NoKK)
		}
		existingWarga.NoKK = req.NoKK
	}

	if req.TempatLahir != "" {
		existingWarga.TempatLahir = req.TempatLahir
	}

	if req.TanggalLahir != nil && *req.TanggalLahir != "" {
		tglLahir, err := time.Parse("2006-01-02", *req.TanggalLahir)
		if err != nil {
			return nil, fmt.Errorf("format tanggal lahir tidak valid: %w", err)
		}
		existingWarga.TanggalLahir = tglLahir
	}

	if req.JenisKelamin != nil {
		existingWarga.JenisKelamin = *req.JenisKelamin
	}

	if req.Agama != nil {
		existingWarga.Agama = *req.Agama
	}

	if req.Pendidikan != "" {
		existingWarga.Pendidikan = req.Pendidikan
	}

	if req.JenisPekerjaan != "" {
		existingWarga.JenisPekerjaan = req.JenisPekerjaan
	}

	if req.GolonganDarah != nil {
		existingWarga.GolonganDarah = req.GolonganDarah
	}

	if req.StatusPerkawinan != nil {
		existingWarga.StatusPerkawinan = *req.StatusPerkawinan
	}

	if req.TanggalPerkawinan != nil && *req.TanggalPerkawinan != "" {
		tglNikah, err := time.Parse("2006-01-02", *req.TanggalPerkawinan)
		if err != nil {
			return nil, fmt.Errorf("format tanggal perkawinan tidak valid: %w", err)
		}
		existingWarga.TanggalPerkawinan = &tglNikah
	}

	if req.StatusKeluarga != nil {
		// Validasi jika status keluarga berubah menjadi kepala keluarga
		if *req.StatusKeluarga == model.StatusKeluargaKepalaKeluarga && 
		   existingWarga.StatusKeluarga != model.StatusKeluargaKepalaKeluarga {
			existingKepalaKeluarga, err := u.repo.GetKepalaKeluargaByNoKK(ctx, existingWarga.NoKK)
			if err != nil {
				return nil, fmt.Errorf("error checking kepala keluarga: %w", err)
			}
			if existingKepalaKeluarga != nil {
				return nil, fmt.Errorf("sudah ada kepala keluarga untuk kartu keluarga ini")
			}
		}
		existingWarga.StatusKeluarga = *req.StatusKeluarga
	}

	if req.Kewarganegaraan != "" {
		existingWarga.Kewarganegaraan = req.Kewarganegaraan
	}

	if req.NamaAyah != "" {
		existingWarga.NamaAyah = req.NamaAyah
	}

	if req.NamaIbu != "" {
		existingWarga.NamaIbu = req.NamaIbu
	}

	existingWarga.UpdatedAt = time.Now()

	err = u.repo.Update(ctx, existingWarga)
	if err != nil {
		return nil, fmt.Errorf("error updating warga: %w", err)
	}

	// Update kartu keluarga jika status berubah menjadi kepala keluarga
	if req.StatusKeluarga != nil && *req.StatusKeluarga == model.StatusKeluargaKepalaKeluarga {
		existingKK, err := u.kkRepo.GetByNoKK(ctx, existingWarga.NoKK)
		if err == nil && existingKK != nil {
			existingKK.KepalaKeluargaID = &existingWarga.ID
			u.kkRepo.Update(ctx, existingKK)
		}
	}

	return existingWarga, nil
}

func (u *WargaUsecase) Delete(ctx context.Context, id uuid.UUID) error {
	// Cek apakah warga ada
	existingWarga, err := u.repo.GetByID(ctx, id)
	if err != nil {
		return fmt.Errorf("error checking existing warga: %w", err)
	}
	if existingWarga == nil {
		return fmt.Errorf("warga tidak ditemukan")
	}

	// Jika warga adalah kepala keluarga, hapus referensi di kartu keluarga
	if existingWarga.StatusKeluarga == model.StatusKeluargaKepalaKeluarga {
		existingKK, err := u.kkRepo.GetByNoKK(ctx, existingWarga.NoKK)
		if err == nil && existingKK != nil {
			existingKK.KepalaKeluargaID = nil
			u.kkRepo.Update(ctx, existingKK)
		}
	}

	err = u.repo.Delete(ctx, id)
	if err != nil {
		return fmt.Errorf("error deleting warga: %w", err)
	}

	return nil
}

func (u *WargaUsecase) GetKepalaKeluargaByNoKK(ctx context.Context, noKK string) (*model.Warga, error) {
	warga, err := u.repo.GetKepalaKeluargaByNoKK(ctx, noKK)
	if err != nil {
		return nil, fmt.Errorf("error getting kepala keluarga: %w", err)
	}
	if warga == nil {
		return nil, fmt.Errorf("kepala keluarga tidak ditemukan")
	}
	return warga, nil
}

func (u *WargaUsecase) GetAnggotaKeluargaByNoKK(ctx context.Context, noKK string) ([]*model.Warga, error) {
	wargas, err := u.repo.GetAnggotaKeluargaByNoKK(ctx, noKK)
	if err != nil {
		return nil, fmt.Errorf("error getting anggota keluarga: %w", err)
	}
	return wargas, nil
} 

func (u *WargaUsecase) GetAnggotaKeluargaByUserID(ctx context.Context, userID string) ([]*model.Warga, error) {
	// Parse user ID to UUID
	userUUID, err := uuid.Parse(userID)
	if err != nil {
		return nil, fmt.Errorf("invalid user ID format: %w", err)
	}

	// Get user to find wargaID
	user, err := u.userRepo.FindByID(ctx, userUUID)
	if err != nil {
		return nil, fmt.Errorf("error getting user: %w", err)
	}

	if user.WargaID == nil {
		return nil, fmt.Errorf("user tidak memiliki wargaID")
	}

	// Get warga data to find NoKK
	warga, err := u.repo.GetByID(ctx, *user.WargaID)
	if err != nil {
		return nil, fmt.Errorf("error getting warga: %w", err)
	}

	// Get anggota keluarga by NoKK
	wargas, err := u.repo.GetAnggotaKeluargaByNoKK(ctx, warga.NoKK)
	if err != nil {
		return nil, fmt.Errorf("error getting anggota keluarga: %w", err)
	}

	return wargas, nil
}

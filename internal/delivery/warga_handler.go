package delivery

import (
	"fmt" // Tambahkan import ini
	"net/http"
	"strconv"
	"time"

	"backend-warga/internal/model"
	"backend-warga/internal/usecase"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

type WargaHandler struct {
	usecase *usecase.WargaUsecase
}

func NewWargaHandler(usecase *usecase.WargaUsecase) *WargaHandler {
	return &WargaHandler{usecase: usecase}
}

func (h *WargaHandler) Create(c *gin.Context) {
	var req model.CreateWargaRequest
	
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": fmt.Sprintf("Invalid request body: %v", err),
		})
		return
	}

	// Validasi input
	if req.NamaLengkap == "" {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "Nama lengkap wajib diisi",
		})
		return
	}

	if req.NIK == "" {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "NIK wajib diisi",
		})
		return
	}

	if len(req.NIK) != 16 {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "NIK harus 16 digit",
		})
		return
	}

	if req.NoKK == "" {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "Nomor KK wajib diisi",
		})
		return
	}

	if len(req.NoKK) != 16 {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "Nomor KK harus 16 digit",
		})
		return
	}

	// Validasi tanggal lahir
	if req.TanggalLahir == "" {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "Tanggal lahir wajib diisi",
		})
		return
	}

	// Validasi format tanggal lahir
	if _, err := time.Parse("2006-01-02", req.TanggalLahir); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "Format tanggal lahir tidak valid (gunakan YYYY-MM-DD)",
		})
		return
	}

	// Validasi format tanggal perkawinan jika ada
	if req.TanggalPerkawinan != nil && *req.TanggalPerkawinan != "" {
		if _, err := time.Parse("2006-01-02", *req.TanggalPerkawinan); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{
				"status":  "error",
				"message": "Format tanggal perkawinan tidak valid (gunakan YYYY-MM-DD)",
			})
			return
		}
	}

	if req.JenisKelamin == "" {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "Jenis kelamin wajib dipilih",
		})
		return
	}

	// Validasi jenis kelamin
	if req.JenisKelamin != model.JenisKelaminLakiLaki && req.JenisKelamin != model.JenisKelaminPerempuan {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "Jenis kelamin harus 'Laki-laki' atau 'Perempuan'",
		})
		return
	}

	if req.Agama == "" {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "Agama wajib dipilih",
		})
		return
	}

	// Validasi agama
	validAgama := []model.Agama{
		model.AgamaIslam, model.AgamaKristen, model.AgamaKatolik,
		model.AgamaHindu, model.AgamaBuddha, model.AgamaKonghucu, model.AgamaLainnya,
	}
	isValidAgama := false
	for _, validValue := range validAgama {
		if req.Agama == validValue {
			isValidAgama = true
			break
		}
	}
	if !isValidAgama {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "Agama tidak valid",
		})
		return
	}

	if req.StatusPerkawinan == "" {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "Status perkawinan wajib dipilih",
		})
		return
	}

	// Validasi status perkawinan
	validStatusPerkawinan := []model.StatusPerkawinan{
		model.StatusPerkawinanBelumKawin, model.StatusPerkawinanKawin,
		model.StatusPerkawinanCeraiHidup, model.StatusPerkawinanCeraiMati,
	}
	isValidStatusPerkawinan := false
	for _, validValue := range validStatusPerkawinan {
		if req.StatusPerkawinan == validValue {
			isValidStatusPerkawinan = true
			break
		}
	}
	if !isValidStatusPerkawinan {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "Status perkawinan tidak valid",
		})
		return
	}

	if req.StatusKeluarga == "" {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "Status keluarga wajib dipilih",
		})
		return
	}

	// Validasi status keluarga
	validStatusKeluarga := []model.StatusKeluarga{
		model.StatusKeluargaKepalaKeluarga, model.StatusKeluargaSuami,
		model.StatusKeluargaIstri, model.StatusKeluargaAnak,
		model.StatusKeluargaOrangTua, model.StatusKeluargaLainnya,
	}
	isValidStatusKeluarga := false
	for _, validValue := range validStatusKeluarga {
		if req.StatusKeluarga == validValue {
			isValidStatusKeluarga = true
			break
		}
	}
	if !isValidStatusKeluarga {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "Status keluarga tidak valid",
		})
		return
	}

	if req.Kewarganegaraan == "" {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "Kewarganegaraan wajib diisi",
		})
		return
	}

	// Validasi golongan darah jika ada
	if req.GolonganDarah != nil {
		validGolonganDarah := []model.GolonganDarah{
			model.GolonganDarahA, model.GolonganDarahB,
			model.GolonganDarahAB, model.GolonganDarahO,
		}
		isValidGolonganDarah := false
		for _, validValue := range validGolonganDarah {
			if *req.GolonganDarah == validValue {
				isValidGolonganDarah = true
				break
			}
		}
		if !isValidGolonganDarah {
			c.JSON(http.StatusBadRequest, gin.H{
				"status":  "error",
				"message": "Golongan darah tidak valid",
			})
			return
		}
	}

	ctx := c.Request.Context()
	warga, err := h.usecase.Create(ctx, &req)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": err.Error(),
		})
		return
	}

	response := Response{
		Status:  "success",
		Message: "Warga berhasil ditambahkan",
		Data:    warga,
	}

	c.JSON(http.StatusCreated, response)
}

func (h *WargaHandler) GetByID(c *gin.Context) {
	idStr := c.Param("id")

	id, err := uuid.Parse(idStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "Invalid ID format",
		})
		return
	}

	ctx := c.Request.Context()
	warga, err := h.usecase.GetByID(ctx, id)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{
			"status":  "error",
			"message": err.Error(),
		})
		return
	}

	response := Response{
		Status:  "success",
		Message: "Warga ditemukan",
		Data:    warga,
	}

	c.JSON(http.StatusOK, response)
}

func (h *WargaHandler) GetByNIK(c *gin.Context) {
	nik := c.Param("nik")

	if nik == "" {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "NIK wajib diisi",
		})
		return
	}

	ctx := c.Request.Context()
	warga, err := h.usecase.GetByNIK(ctx, nik)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{
			"status":  "error",
			"message": err.Error(),
		})
		return
	}

	response := Response{
		Status:  "success",
		Message: "Warga ditemukan",
		Data:    warga,
	}

	c.JSON(http.StatusOK, response)
}

func (h *WargaHandler) GetByNoKK(c *gin.Context) {
	noKK := c.Param("no_kk")

	if noKK == "" {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "Nomor KK wajib diisi",
		})
		return
	}

	ctx := c.Request.Context()
	wargas, err := h.usecase.GetByNoKK(ctx, noKK)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"status":  "error",
			"message": err.Error(),
		})
		return
	}

	response := Response{
		Status:  "success",
		Message: "Daftar warga berhasil diambil",
		Data: map[string]interface{}{
			"wargas": wargas,
			"total":  len(wargas),
		},
	}

	c.JSON(http.StatusOK, response)
}

func (h *WargaHandler) GetAll(c *gin.Context) {
	// Parse query parameters untuk pagination
	pageStr := c.Query("page")
	limitStr := c.Query("limit")

	page := 1
	limit := 10

	if pageStr != "" {
		if p, err := strconv.Atoi(pageStr); err == nil && p > 0 {
			page = p
		}
	}

	if limitStr != "" {
		if l, err := strconv.Atoi(limitStr); err == nil && l > 0 && l <= 100 {
			limit = l
		}
	}

	ctx := c.Request.Context()
	wargas, err := h.usecase.GetAll(ctx)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"status":  "error",
			"message": err.Error(),
		})
		return
	}

	// Simple pagination
	start := (page - 1) * limit
	end := start + limit

	if start >= len(wargas) {
		start = len(wargas)
	}
	if end > len(wargas) {
		end = len(wargas)
	}

	var data []*model.Warga
	if start < len(wargas) {
		data = wargas[start:end]
	}

	response := Response{
		Status:  "success",
		Message: "Daftar warga berhasil diambil",
		Data: map[string]interface{}{
			"wargas": data,
			"pagination": map[string]interface{}{
				"page":       page,
				"limit":      limit,
				"total":      len(wargas),
				"total_page": (len(wargas) + limit - 1) / limit,
			},
		},
	}

	c.JSON(http.StatusOK, response)
}

func (h *WargaHandler) Update(c *gin.Context) {
	idStr := c.Param("id")

	id, err := uuid.Parse(idStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "Invalid ID format",
		})
		return
	}

	var req model.UpdateWargaRequest
	
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "Invalid request body",
		})
		return
	}

	ctx := c.Request.Context()
	warga, err := h.usecase.Update(ctx, id, &req)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": err.Error(),
		})
		return
	}

	response := Response{
		Status:  "success",
		Message: "Warga berhasil diperbarui",
		Data:    warga,
	}

	c.JSON(http.StatusOK, response)
}

func (h *WargaHandler) Delete(c *gin.Context) {
	idStr := c.Param("id")

	id, err := uuid.Parse(idStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "Invalid ID format",
		})
		return
	}

	ctx := c.Request.Context()
	err = h.usecase.Delete(ctx, id)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": err.Error(),
		})
		return
	}

	response := Response{
		Status:  "success",
		Message: "Warga berhasil dihapus",
	}

	c.JSON(http.StatusOK, response)
}

func (h *WargaHandler) GetKepalaKeluargaByNoKK(c *gin.Context) {
	noKK := c.Param("no_kk")

	if noKK == "" {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "Nomor KK wajib diisi",
		})
		return
	}

	ctx := c.Request.Context()
	warga, err := h.usecase.GetKepalaKeluargaByNoKK(ctx, noKK)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{
			"status":  "error",
			"message": err.Error(),
		})
		return
	}

	response := Response{
		Status:  "success",
		Message: "Kepala keluarga ditemukan",
		Data:    warga,
	}

	c.JSON(http.StatusOK, response)
}

func (h *WargaHandler) GetAnggotaKeluargaByNoKK(c *gin.Context) {
	noKK := c.Param("no_kk")

	if noKK == "" {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "Nomor KK wajib diisi",
		})
		return
	}

	ctx := c.Request.Context()
	wargas, err := h.usecase.GetAnggotaKeluargaByNoKK(ctx, noKK)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"status":  "error",
			"message": err.Error(),
		})
		return
	}

	response := Response{
		Status:  "success",
		Message: "Anggota keluarga berhasil diambil",
		Data: map[string]interface{}{
			"anggota_keluarga": wargas,
			"total":            len(wargas),
		},
	}

	c.JSON(http.StatusOK, response)
}

// GetAnggotaKeluargaByUserID godoc
// @Summary Get anggota keluarga by user ID
// @Description Get anggota keluarga based on user's wargaID
// @Tags warga
// @Accept json
// @Produce json
// @Param user_id path string true "User ID"
// @Success 200 {object} Response
// @Router /warga/user/{user_id}/anggota-keluarga [get]
func (h *WargaHandler) GetAnggotaKeluargaByUserID(c *gin.Context) {
	userID := c.Param("user_id")

	if userID == "" {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "User ID wajib diisi",
		})
		return
	}

	ctx := c.Request.Context()
	wargas, err := h.usecase.GetAnggotaKeluargaByUserID(ctx, userID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"status":  "error",
			"message": err.Error(),
		})
		return
	}

	response := Response{
		Status:  "success",
		Message: "Anggota keluarga berhasil diambil",
		Data: map[string]interface{}{
			"anggota_keluarga": wargas,
			"total":            len(wargas),
		},
	}

	c.JSON(http.StatusOK, response)
}

func RegisterWargaRoutes(r *gin.Engine, uc *usecase.WargaUsecase) {
	handler := NewWargaHandler(uc)

	api := r.Group("/api")
	{
		api.POST("/warga", handler.Create)
		api.GET("/warga", handler.GetAll)
		api.GET("/warga/:id", handler.GetByID)
		api.GET("/warga/nik/:nik", handler.GetByNIK)
		api.GET("/warga/kk/:no_kk", handler.GetByNoKK)
		api.GET("/warga/kepala-keluarga/:no_kk", handler.GetKepalaKeluargaByNoKK)
		api.GET("/warga/anggota-keluarga/:no_kk", handler.GetAnggotaKeluargaByNoKK)
		api.GET("/warga/user/:user_id/anggota-keluarga", handler.GetAnggotaKeluargaByUserID)
		api.PUT("/warga/:id", handler.Update)
		api.DELETE("/warga/:id", handler.Delete)
	}
} 

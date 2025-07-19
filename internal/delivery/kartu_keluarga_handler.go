package delivery

import (
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"backend-warga/internal/model"
	"backend-warga/internal/usecase"
)

type KartuKeluargaHandler struct {
	usecase *usecase.KartuKeluargaUsecase
}

func NewKartuKeluargaHandler(usecase *usecase.KartuKeluargaUsecase) *KartuKeluargaHandler {
	return &KartuKeluargaHandler{usecase: usecase}
}

type Response struct {
	Status  string      `json:"status"`
	Message string      `json:"message"`
	Data    interface{} `json:"data,omitempty"`
}

func (h *KartuKeluargaHandler) Create(c *gin.Context) {
	var req model.CreateKartuKeluargaRequest
	
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "Invalid request body",
		})
		return
	}

	// Validasi input
	if req.NoKK == "" {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "Nomor KK wajib diisi",
		})
		return
	}

	if req.ProvinsiID == 0 {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "Provinsi wajib dipilih",
		})
		return
	}

	if req.KotaID == 0 {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "Kota wajib dipilih",
		})
		return
	}

	if req.KecamatanID == 0 {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "Kecamatan wajib dipilih",
		})
		return
	}

	if req.KelurahanID == 0 {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "Kelurahan wajib dipilih",
		})
		return
	}

	if req.RTID == 0 {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "RT wajib dipilih",
		})
		return
	}

	if req.RWID == 0 {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "RW wajib dipilih",
		})
		return
	}

	if req.Alamat == "" {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "Alamat wajib diisi",
		})
		return
	}

	if req.KodePos == "" {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "Kode pos wajib diisi",
		})
		return
	}

	ctx := c.Request.Context()
	kk, err := h.usecase.Create(ctx, &req)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": err.Error(),
		})
		return
	}

	response := Response{
		Status:  "success",
		Message: "Kartu keluarga berhasil dibuat",
		Data:    kk,
	}

	c.JSON(http.StatusCreated, response)
}

func (h *KartuKeluargaHandler) GetByID(c *gin.Context) {
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
	kk, err := h.usecase.GetByID(ctx, id)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{
			"status":  "error",
			"message": err.Error(),
		})
		return
	}

	response := Response{
		Status:  "success",
		Message: "Kartu keluarga ditemukan",
		Data:    kk,
	}

	c.JSON(http.StatusOK, response)
}

func (h *KartuKeluargaHandler) GetByNoKK(c *gin.Context) {
	noKK := c.Param("no_kk")

	if noKK == "" {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "Nomor KK wajib diisi",
		})
		return
	}

	ctx := c.Request.Context()
	kk, err := h.usecase.GetByNoKK(ctx, noKK)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{
			"status":  "error",
			"message": err.Error(),
		})
		return
	}

	response := Response{
		Status:  "success",
		Message: "Kartu keluarga ditemukan",
		Data:    kk,
	}

	c.JSON(http.StatusOK, response)
}

func (h *KartuKeluargaHandler) GetAll(c *gin.Context) {
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
	kartuKeluargas, err := h.usecase.GetAll(ctx)
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

	if start >= len(kartuKeluargas) {
		start = len(kartuKeluargas)
	}
	if end > len(kartuKeluargas) {
		end = len(kartuKeluargas)
	}

	var data []*model.KartuKeluarga
	if start < len(kartuKeluargas) {
		data = kartuKeluargas[start:end]
	}

	response := Response{
		Status:  "success",
		Message: "Daftar kartu keluarga berhasil diambil",
		Data: map[string]interface{}{
			"kartu_keluargas": data,
			"pagination": map[string]interface{}{
				"page":       page,
				"limit":      limit,
				"total":      len(kartuKeluargas),
				"total_page": (len(kartuKeluargas) + limit - 1) / limit,
			},
		},
	}

	c.JSON(http.StatusOK, response)
}

func (h *KartuKeluargaHandler) Update(c *gin.Context) {
	idStr := c.Param("id")

	id, err := uuid.Parse(idStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "Invalid ID format",
		})
		return
	}

	var req model.UpdateKartuKeluargaRequest
	
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": "Invalid request body",
		})
		return
	}

	ctx := c.Request.Context()
	kk, err := h.usecase.Update(ctx, id, &req)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "error",
			"message": err.Error(),
		})
		return
	}

	response := Response{
		Status:  "success",
		Message: "Kartu keluarga berhasil diperbarui",
		Data:    kk,
	}

	c.JSON(http.StatusOK, response)
}

func (h *KartuKeluargaHandler) Delete(c *gin.Context) {
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
		Message: "Kartu keluarga berhasil dihapus",
	}

	c.JSON(http.StatusOK, response)
}

func RegisterKartuKeluargaRoutes(r *gin.Engine, uc *usecase.KartuKeluargaUsecase) {
	handler := NewKartuKeluargaHandler(uc)

	api := r.Group("/api")
	{
		api.POST("/kartu-keluarga", handler.Create)
		api.GET("/kartu-keluarga", handler.GetAll)
		api.GET("/kartu-keluarga/:id", handler.GetByID)
		api.GET("/kartu-keluarga/no-kk/:no_kk", handler.GetByNoKK)
		api.PUT("/kartu-keluarga/:id", handler.Update)
		api.DELETE("/kartu-keluarga/:id", handler.Delete)
	}
} 
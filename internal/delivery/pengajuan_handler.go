package delivery

import (
	"log"
	"net/http"
	"strconv"

	"backend-warga/internal/model"
	"backend-warga/internal/repository"
	"backend-warga/internal/usecase"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

type PengajuanHandler struct {
	pengajuanUseCase  usecase.PengajuanUseCase
	kartuKeluargaRepo repository.KartuKeluargaRepository
}

func NewPengajuanHandler(pengajuanUseCase usecase.PengajuanUseCase, kkRepo repository.KartuKeluargaRepository) *PengajuanHandler {
	return &PengajuanHandler{
		pengajuanUseCase:  pengajuanUseCase,
		kartuKeluargaRepo: kkRepo,
	}
}

// GetPengajuanList godoc
// @Summary Get all pengajuan
// @Description Get list of all pengajuan
// @Tags pengajuan
// @Accept json
// @Produce json
// @Success 200 {array} model.Pengajuan
// @Router /pengajuan [get]
func (h *PengajuanHandler) GetPengajuanList(c *gin.Context) {
	pengajuanList, err := h.pengajuanUseCase.GetAllPengajuan()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, pengajuanList)
}

// GetPengajuanByID godoc
// @Summary Get pengajuan by ID
// @Description Get pengajuan by ID
// @Tags pengajuan
// @Accept json
// @Produce json
// @Param id path string true "Pengajuan ID"
// @Success 200 {object} model.Pengajuan
// @Router /pengajuan/{id} [get]
func (h *PengajuanHandler) GetPengajuanByID(c *gin.Context) {
	id := c.Param("id")

	pengajuan, err := h.pengajuanUseCase.GetPengajuanByID(id)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Pengajuan not found"})
		return
	}

	c.JSON(http.StatusOK, pengajuan)
}

// GetPengajuanByWargaID godoc
// @Summary Get pengajuan by warga ID
// @Description Get pengajuan by warga ID
// @Tags pengajuan
// @Accept json
// @Produce json
// @Param warga_id path string true "Warga ID"
// @Success 200 {array} model.Pengajuan
// @Router /pengajuan/warga/{warga_id} [get]
func (h *PengajuanHandler) GetPengajuanByWargaID(c *gin.Context) {
	wargaID := c.Param("warga_id")

	pengajuanList, err := h.pengajuanUseCase.GetPengajuanByWargaID(wargaID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, pengajuanList)
}

// GetPengajuanByStatus godoc
// @Summary Get pengajuan by status
// @Description Get pengajuan by status
// @Tags pengajuan
// @Accept json
// @Produce json
// @Param status path string true "Status"
// @Success 200 {array} model.Pengajuan
// @Router /pengajuan/status/{status} [get]
func (h *PengajuanHandler) GetPengajuanByStatus(c *gin.Context) {
	status := c.Param("status")

	pengajuanList, err := h.pengajuanUseCase.GetPengajuanByStatus(status)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, pengajuanList)
}

// CreatePengajuan godoc
// @Summary Create new pengajuan
// @Description Create a new pengajuan
// @Tags pengajuan
// @Accept json
// @Produce json
// @Param pengajuan body model.Pengajuan true "Pengajuan object"
// @Success 201 {object} model.Pengajuan
// @Router /pengajuan [post]
func (h *PengajuanHandler) CreatePengajuan(c *gin.Context) {
	var pengajuan model.Pengajuan

	if err := c.ShouldBindJSON(&pengajuan); err != nil {
		log.Println("[DEBUG] Error binding JSON:", err)
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	err := h.pengajuanUseCase.CreatePengajuan(&pengajuan)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusCreated, pengajuan)
}

// UpdatePengajuan godoc
// @Summary Update pengajuan
// @Description Update pengajuan by ID
// @Tags pengajuan
// @Accept json
// @Produce json
// @Param id path string true "Pengajuan ID"
// @Param pengajuan body model.Pengajuan true "Pengajuan object"
// @Success 200 {object} model.Pengajuan
// @Router /pengajuan/{id} [put]
func (h *PengajuanHandler) UpdatePengajuan(c *gin.Context) {
	id := c.Param("id")

	var pengajuan model.Pengajuan
	if err := c.ShouldBindJSON(&pengajuan); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	uuidID, err := uuid.Parse(id)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid pengajuan ID"})
		return
	}
	pengajuan.ID = uuidID

	err = h.pengajuanUseCase.UpdatePengajuan(&pengajuan)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, pengajuan)
}

// DeletePengajuan godoc
// @Summary Delete pengajuan
// @Description Delete pengajuan by ID
// @Tags pengajuan
// @Accept json
// @Produce json
// @Param id path string true "Pengajuan ID"
// @Success 200 {object} gin.H
// @Router /pengajuan/{id} [delete]
func (h *PengajuanHandler) DeletePengajuan(c *gin.Context) {
	id := c.Param("id")

	err := h.pengajuanUseCase.DeletePengajuan(id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Pengajuan deleted successfully"})
}

// ApprovePengajuan godoc
// @Summary Approve pengajuan
// @Description Approve pengajuan by ID
// @Tags pengajuan
// @Accept json
// @Produce json
// @Param id path string true "Pengajuan ID"
// @Param approved_by query string true "Approved by"
// @Success 200 {object} gin.H
// @Router /pengajuan/{id}/approve [put]
func (h *PengajuanHandler) ApprovePengajuan(c *gin.Context) {
	id := c.Param("id")
	approvedBy := c.Query("approved_by")

	if approvedBy == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "approved_by is required"})
		return
	}

	err := h.pengajuanUseCase.ApprovePengajuan(id, approvedBy)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Pengajuan approved successfully"})
}

// RejectPengajuan godoc
// @Summary Reject pengajuan
// @Description Reject pengajuan by ID
// @Tags pengajuan
// @Accept json
// @Produce json
// @Param id path string true "Pengajuan ID"
// @Param rejected_by query string true "Rejected by"
// @Param reason query string true "Rejection reason"
// @Success 200 {object} gin.H
// @Router /pengajuan/{id}/reject [put]
func (h *PengajuanHandler) RejectPengajuan(c *gin.Context) {
	id := c.Param("id")
	rejectedBy := c.Query("rejected_by")
	reason := c.Query("reason")

	if rejectedBy == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "rejected_by is required"})
		return
	}

	if reason == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "reason is required"})
		return
	}

	err := h.pengajuanUseCase.RejectPengajuan(id, rejectedBy, reason)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Pengajuan rejected successfully"})
}

// List pengajuan untuk RT
func (h *PengajuanHandler) GetPengajuanByRTID(c *gin.Context) {
	// Ambil user dari context
	user, exists := c.Get("user")
	if !exists {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Unauthorized"})
		return
	}
	userModel, ok := user.(*model.User)
	if !ok {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Unauthorized"})
		return
	}
	if userModel.Role != model.RoleRT {
		c.JSON(http.StatusForbidden, gin.H{"error": "Hanya RT yang boleh mengakses"})
		return
	}

	// Ambil param RT ID dari URL
	paramRTIDStr := c.Param("rt_id")
	paramRTID, err := strconv.Atoi(paramRTIDStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid RT ID"})
		return
	}

	// Ambil no_kk dari warga user RT
	if userModel.Warga == nil {
		log.Println("[DEBUG] Data warga tidak ditemukan pada user:", userModel)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Data warga tidak ditemukan pada user"})
		return
	}
	noKK := userModel.Warga.NoKK

	// Query kartu keluarga berdasarkan no_kk
	kk, err := h.kartuKeluargaRepo.GetByNoKK(c.Request.Context(), noKK)
	if err != nil || kk == nil {
		log.Println("[DEBUG] Gagal mengambil data kartu keluarga:", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Gagal mengambil data kartu keluarga"})
		return
	}
	userRTID := kk.RTID

	// Validasi RT ID
	if paramRTID != userRTID {
		c.JSON(http.StatusForbidden, gin.H{"error": "Tidak boleh mengakses pengajuan RT lain"})
		return
	}

	// Jika lolos, ambil data pengajuan
	pengajuans, err := h.pengajuanUseCase.GetByRTID(c.Request.Context(), paramRTID)
	if err != nil {
		log.Println("[DEBUG] Error get pengajuan by RTID:", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, pengajuans)
}

// RT approve
func (h *PengajuanHandler) ApprovePengajuanByRT(c *gin.Context) {
	id := c.Param("id")
	var req struct {
		TtdRTUrl string `json:"ttd_rt_url"`
	}
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return
	}
	err := h.pengajuanUseCase.ApproveByRT(c.Request.Context(), id, req.TtdRTUrl)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "Pengajuan approved by RT"})
}

// RT reject
func (h *PengajuanHandler) RejectPengajuanByRT(c *gin.Context) {
	id := c.Param("id")
	err := h.pengajuanUseCase.RejectByRT(c.Request.Context(), id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "Pengajuan rejected by RT"})
}

func RegisterPengajuanRoutes(r *gin.Engine, uc usecase.PengajuanUseCase, kkRepo repository.KartuKeluargaRepository, authMiddleware interface {
	RequireToken(...string) gin.HandlerFunc
}) {
	handler := NewPengajuanHandler(uc, kkRepo)

	api := r.Group("/api")
	{
		api.GET("/pengajuan", handler.GetPengajuanList)
		api.GET("/pengajuan/:id", handler.GetPengajuanByID)
		api.GET("/pengajuan/warga/:warga_id", handler.GetPengajuanByWargaID)
		api.GET("/pengajuan/status/:status", handler.GetPengajuanByStatus)
		api.POST("/pengajuan", handler.CreatePengajuan)
		api.PUT("/pengajuan/:id", handler.UpdatePengajuan)
		api.DELETE("/pengajuan/:id", handler.DeletePengajuan)
		api.PUT("/pengajuan/:id/approve", handler.ApprovePengajuan)
		api.PUT("/pengajuan/:id/reject", handler.RejectPengajuan)
		api.GET("/pengajuan/rt/:rt_id", authMiddleware.RequireToken("rt"), handler.GetPengajuanByRTID)
		api.PUT("/pengajuan/:id/approve-rt", handler.ApprovePengajuanByRT)
		api.PUT("/pengajuan/:id/reject-rt", handler.RejectPengajuanByRT)
	}
}

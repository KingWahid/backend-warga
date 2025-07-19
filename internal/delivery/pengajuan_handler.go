package delivery

import (
	"net/http"

	"backend-warga/internal/model"
	"backend-warga/internal/usecase"

	"github.com/gin-gonic/gin"
)

type PengajuanHandler struct {
	pengajuanUseCase usecase.PengajuanUseCase
}

func NewPengajuanHandler(pengajuanUseCase usecase.PengajuanUseCase) *PengajuanHandler {
	return &PengajuanHandler{
		pengajuanUseCase: pengajuanUseCase,
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

	pengajuan.ID = id
	err := h.pengajuanUseCase.UpdatePengajuan(&pengajuan)
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

func RegisterPengajuanRoutes(r *gin.Engine, uc usecase.PengajuanUseCase) {
	handler := NewPengajuanHandler(uc)

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
	}
}

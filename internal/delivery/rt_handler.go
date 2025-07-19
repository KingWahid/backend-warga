package delivery

import (
	"net/http"
	"backend-warga/internal/model"
	"backend-warga/internal/usecase"
	"github.com/gin-gonic/gin"
	"strconv"
)

type RTHandler struct {
	Usecase usecase.RTUsecase
}

func RegisterRTRoutes(r *gin.Engine, uc usecase.RTUsecase) {
	h := &RTHandler{uc}
	r.POST("/api/rt", h.CreateRT)
	r.GET("/api/rt", h.GetRTByKelurahanID)
}

func (h *RTHandler) CreateRT(c *gin.Context) {
	var req model.RT
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := h.Usecase.CreateRT(c.Request.Context(), &req); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusCreated, req)
}

func (h *RTHandler) GetRTByKelurahanID(c *gin.Context) {
	kelurahanIDStr := c.Query("kelurahan_id")
	kelurahanID, _ := strconv.ParseUint(kelurahanIDStr, 10, 32)
	data, err := h.Usecase.GetRTByKelurahanID(c.Request.Context(), uint(kelurahanID))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, data)
} 
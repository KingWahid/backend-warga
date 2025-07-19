package delivery

import (
	"net/http"
	"backend-warga/internal/model"
	"backend-warga/internal/usecase"
	"github.com/gin-gonic/gin"
	"strconv"
)

type RWHandler struct {
	Usecase usecase.RWUsecase
}

func RegisterRWRoutes(r *gin.Engine, uc usecase.RWUsecase) {
	h := &RWHandler{uc}
	r.POST("/api/rw", h.CreateRW)
	r.GET("/api/rw", h.GetRWByKelurahanID)
}

func (h *RWHandler) CreateRW(c *gin.Context) {
	var req model.RW
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := h.Usecase.CreateRW(c.Request.Context(), &req); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusCreated, req)
}

func (h *RWHandler) GetRWByKelurahanID(c *gin.Context) {
	kelurahanIDStr := c.Query("kelurahan_id")
	kelurahanID, _ := strconv.ParseUint(kelurahanIDStr, 10, 32)
	data, err := h.Usecase.GetRWByKelurahanID(c.Request.Context(), uint(kelurahanID))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, data)
} 
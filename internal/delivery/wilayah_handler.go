package delivery

import (
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
	"backend-warga/internal/usecase"
)

type WilayahHandler struct {
	Usecase usecase.WilayahUsecase
}

func RegisterWilayahRoutes(r *gin.Engine, uc usecase.WilayahUsecase) {
	handler := &WilayahHandler{uc}

	api := r.Group("/api")
	{
		api.GET("/provinsi", handler.GetProvinsi)
		api.GET("/kota", handler.GetKota)
		api.GET("/kecamatan", handler.GetKecamatan)
		api.GET("/kelurahan", handler.GetKelurahan)
	}
}

func (h *WilayahHandler) GetProvinsi(c *gin.Context) {
	data, err := h.Usecase.GetAllProvinsi(c.Request.Context())
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, data)
}

func (h *WilayahHandler) GetKota(c *gin.Context) {
	provinsiIDStr := c.Query("provinsi_id")
	provinsiID, _ := strconv.ParseUint(provinsiIDStr, 10, 32)
	data, err := h.Usecase.GetKotaByProvinsi(c.Request.Context(), uint(provinsiID))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, data)
}

func (h *WilayahHandler) GetKecamatan(c *gin.Context) {
	kotaIDStr := c.Query("kota_id")
	kotaID, _ := strconv.ParseUint(kotaIDStr, 10, 32)
	data, err := h.Usecase.GetKecamatanByKota(c.Request.Context(), uint(kotaID))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, data)
}

func (h *WilayahHandler) GetKelurahan(c *gin.Context) {
	kecamatanIDStr := c.Query("kecamatan_id")
	kecamatanID, _ := strconv.ParseUint(kecamatanIDStr, 10, 32)
	data, err := h.Usecase.GetKelurahanByKecamatan(c.Request.Context(), uint(kecamatanID))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, data)
}
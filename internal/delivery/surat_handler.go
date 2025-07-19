package delivery

import (
	"net/http"

	"backend-warga/internal/model"
	"backend-warga/internal/usecase"

	"github.com/gin-gonic/gin"
)

type SuratHandler struct {
	suratUseCase usecase.SuratUseCase
}

func NewSuratHandler(suratUseCase usecase.SuratUseCase) *SuratHandler {
	return &SuratHandler{
		suratUseCase: suratUseCase,
	}
}

// GetSuratList godoc
// @Summary Get all surat
// @Description Get list of all surat
// @Tags surat
// @Accept json
// @Produce json
// @Success 200 {array} model.Surat
// @Router /surat [get]
func (h *SuratHandler) GetSuratList(c *gin.Context) {
	suratList, err := h.suratUseCase.GetAllSurat()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, suratList)
}

// GetSuratByID godoc
// @Summary Get surat by ID
// @Description Get surat by ID
// @Tags surat
// @Accept json
// @Produce json
// @Param id path string true "Surat ID"
// @Success 200 {object} model.Surat
// @Router /surat/{id} [get]
func (h *SuratHandler) GetSuratByID(c *gin.Context) {
	id := c.Param("id")

	surat, err := h.suratUseCase.GetSuratByID(id)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Surat not found"})
		return
	}

	c.JSON(http.StatusOK, surat)
}

// CreateSurat godoc
// @Summary Create new surat
// @Description Create a new surat
// @Tags surat
// @Accept json
// @Produce json
// @Param surat body model.Surat true "Surat object"
// @Success 201 {object} model.Surat
// @Router /surat [post]
func (h *SuratHandler) CreateSurat(c *gin.Context) {
	var surat model.Surat

	if err := c.ShouldBindJSON(&surat); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	err := h.suratUseCase.CreateSurat(&surat)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusCreated, surat)
}

// UpdateSurat godoc
// @Summary Update surat
// @Description Update surat by ID
// @Tags surat
// @Accept json
// @Produce json
// @Param id path string true "Surat ID"
// @Param surat body model.Surat true "Surat object"
// @Success 200 {object} model.Surat
// @Router /surat/{id} [put]
func (h *SuratHandler) UpdateSurat(c *gin.Context) {
	id := c.Param("id")

	var surat model.Surat
	if err := c.ShouldBindJSON(&surat); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	surat.ID = id
	err := h.suratUseCase.UpdateSurat(&surat)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, surat)
}

// DeleteSurat godoc
// @Summary Delete surat
// @Description Delete surat by ID
// @Tags surat
// @Accept json
// @Produce json
// @Param id path string true "Surat ID"
// @Success 200 {object} gin.H
// @Router /surat/{id} [delete]
func (h *SuratHandler) DeleteSurat(c *gin.Context) {
	id := c.Param("id")

	err := h.suratUseCase.DeleteSurat(id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Surat deleted successfully"})
}

func RegisterSuratRoutes(r *gin.Engine, uc usecase.SuratUseCase) {
	handler := NewSuratHandler(uc)

	api := r.Group("/api")
	{
		api.GET("/surat", handler.GetSuratList)
		api.GET("/surat/:id", handler.GetSuratByID)
		api.POST("/surat", handler.CreateSurat)
		api.PUT("/surat/:id", handler.UpdateSurat)
		api.DELETE("/surat/:id", handler.DeleteSurat)
	}
}

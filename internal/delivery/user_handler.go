package delivery

import (
	"backend-warga/internal/model"
	"backend-warga/internal/usecase"
	"net/http"

	"github.com/gin-gonic/gin"
)

type UserHandler struct {
	UC usecase.UserUseCase
}

func RegisterUserRoutes(r *gin.Engine, uc usecase.UserUseCase, authMiddleware interface {
	RequireToken(...string) gin.HandlerFunc
}) {
	h := &UserHandler{UC: uc}
	r.POST("/api/auth/register", h.Register)
	r.GET("/api/profile", authMiddleware.RequireToken("user", "kepalakeluarga", "rt", "rw", "admin", "superadmin"), h.Profile)
}

func (h *UserHandler) Register(c *gin.Context) {
	var payload model.User
	if err := c.ShouldBindJSON(&payload); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := h.UC.Create(c.Request.Context(), &payload); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusCreated, gin.H{"message": "user registered successfully"})
}

func (h *UserHandler) Profile(c *gin.Context) {
	user, ok := c.Get("user")
	if !ok {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "unauthorized"})
		return
	}
	c.JSON(http.StatusOK, user)
}

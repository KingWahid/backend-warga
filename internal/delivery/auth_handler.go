package delivery

import (
	"backend-warga/internal/model"
	"backend-warga/internal/usecase"
	"net/http"

	"github.com/gin-gonic/gin"
)

type AuthHandler struct {
	authUc usecase.AuthenticationUseCase
	rg     *gin.RouterGroup
}

func (a *AuthHandler) Route() {
	a.rg.POST("/auth/login", a.loginHandler)
}

func (a *AuthHandler) loginHandler(ctx *gin.Context) {
	var payload *model.User

	// Bind payload
	if err := ctx.ShouldBindJSON(&payload); err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": "invalid request", "detail": err.Error()})
		return
	}

	// Call usecase login
	accessToken, err := a.authUc.Login(payload.Email, payload.Password)
	if err != nil {
		ctx.JSON(http.StatusUnauthorized, gin.H{"error": "invalid credentials", "detail": err.Error()})
		return
	}

	// Success response
	ctx.JSON(http.StatusOK, gin.H{
		"access_token": accessToken,
	})
}

func NewAuthHandler(authUc usecase.AuthenticationUseCase, rg *gin.RouterGroup) *AuthHandler {
	return &AuthHandler{authUc: authUc, rg: rg}
}

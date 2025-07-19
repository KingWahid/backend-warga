package middleware

import (
	"backend-warga/internal/model"
	"backend-warga/internal/repository"
	"backend-warga/pkg/service"
	"context"
	"net/http"
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

type AuthMiddleware interface {
	RequireToken(roles ...string) gin.HandlerFunc
}

type authMiddleware struct {
	jwtService service.JwtService
	userRepo   repository.UserRepository
}

type authHeader struct {
	AuthorizationHeader string `header:"Authorization" binding:"required"`
}

func (a *authMiddleware) RequireToken(roles ...string) gin.HandlerFunc {
	return func(ctx *gin.Context) {
		var aH authHeader
		err := ctx.ShouldBindHeader(&aH)

		if err != nil {
			ctx.AbortWithStatusJSON(http.StatusUnauthorized, gin.H{"message": "Unauthorized"})
			return
		}

		token := strings.TrimPrefix(aH.AuthorizationHeader, "Bearer ")

		tokenClaim, err := a.jwtService.VerifyToken(token)

		if err != nil {
			ctx.AbortWithStatusJSON(http.StatusUnauthorized, gin.H{"message": "Unauthorized"})
			return
		}

		userID, err := uuid.Parse(tokenClaim.UserId)
		if err != nil {
			ctx.AbortWithStatusJSON(http.StatusUnauthorized, gin.H{"message": "invalid user id"})
			return
		}

		userRole := model.Role(tokenClaim.Role)

		// Get full user data from database
		user, err := a.userRepo.FindByID(context.Background(), userID)
		if err != nil {
			ctx.AbortWithStatusJSON(http.StatusUnauthorized, gin.H{"message": "user not found"})
			return
		}

		ctx.Set("user", user)

		validRole := false
		for _, allowed := range roles {
			if userRole == model.Role(allowed) {
				validRole = true
				break
			}
		}

		if !validRole {
			ctx.AbortWithStatusJSON(http.StatusForbidden, gin.H{"message": "Forbidden Resourse"})
			return
		}

		ctx.Next()
	}
}

func NewAuthMiddleware(jwtService service.JwtService, userRepo repository.UserRepository) AuthMiddleware {
	return &authMiddleware{jwtService: jwtService, userRepo: userRepo}
}

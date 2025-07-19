package service

import (
	"fmt"
	"time"

	"backend-warga/config"
	"backend-warga/internal/model"
	modelutil "backend-warga/pkg/model_util"
	"github.com/golang-jwt/jwt/v5"
)

type JwtService interface {
	CreateToken(user model.User) (string, error)
	VerifyToken(token string) (modelutil.JwtPayloadClaim, error)
}

type jwtService struct {
	cfg config.TokenConfig
}

// file: pkg/service/jwt_service.go
func (j *jwtService) CreateToken(user model.User) (string, error) {
	tokenKey := j.cfg.JwtSignatureKey

	claims := modelutil.JwtPayloadClaim{
		RegisteredClaims: jwt.RegisteredClaims{
			Issuer:    j.cfg.ApplicationName,
			ExpiresAt: jwt.NewNumericDate(time.Now().Add(j.cfg.AccessTokenLifeTime)),
		},
		UserId: user.Id.String(),
		Role:   string(user.Role),
	}

	jwtNewClaim := jwt.NewWithClaims(j.cfg.JwtSigningMethod, claims)
	return jwtNewClaim.SignedString(tokenKey)
}

func (j *jwtService) VerifyToken(tokenString string) (modelutil.JwtPayloadClaim, error) {
	tokenParse, err := jwt.ParseWithClaims(tokenString, &modelutil.JwtPayloadClaim{}, func(t *jwt.Token) (interface{}, error) {
		return j.cfg.JwtSignatureKey, nil
	})

	if err != nil {
		return modelutil.JwtPayloadClaim{}, err
	}

	claim, ok := tokenParse.Claims.(*modelutil.JwtPayloadClaim)

	if !ok {
		return modelutil.JwtPayloadClaim{}, fmt.Errorf("error claim")
	}

	return *claim, nil
}

func NewJwtService(cfg config.TokenConfig) JwtService {
	return &jwtService{cfg: cfg}
}
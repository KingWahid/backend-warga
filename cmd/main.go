package main

import (
	"fmt"
	"log"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"

	"backend-warga/config"
	"backend-warga/internal/delivery"
	"backend-warga/internal/repository"
	"backend-warga/internal/usecase"
	"backend-warga/middleware"
	"backend-warga/pkg/service"
)

func main() {
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}

	// Load config
	cfg, err := config.NewConfig()
	if err != nil {
		log.Fatal("failed to load config:", err)
	}

	// DEBUG: Print config values before creating DSN
	fmt.Printf("🔍 Config loaded - Host: '%s', Port: '%s', DB: '%s', User: '%s'\n",
		cfg.Host, cfg.Port, cfg.Database, cfg.Username)

	dsn := fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=disable",
		cfg.Host, cfg.Port, cfg.Username, cfg.Password, cfg.Database)
	fmt.Printf("🔍 DSN: %s\n", dsn)

	// DB
	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Fatal("failed to connect database:", err)
	}

	// Repo & Usecase
	wilayahRepo := repository.NewWilayahRepository(db)
	wilayahUC := usecase.NewWilayahUsecase(wilayahRepo)
	rwRepo := repository.NewRWRepository(db)
	rwUC := usecase.NewRWUsecase(rwRepo)
	rtRepo := repository.NewRTRepository(db)
	rtUC := usecase.NewRTUsecase(rtRepo)
	kkRepo := repository.NewKartuKeluargaRepository(db)
	kkUC := usecase.NewKartuKeluargaUsecase(kkRepo)

	// User repo/usecase
	userRepo := repository.NewUserRepository(db)
	userUC := usecase.NewUserUseCase(userRepo)

	wargaRepo := repository.NewWargaRepository(db)
	wargaUC := usecase.NewWargaUsecase(wargaRepo, kkRepo, userRepo)

	// Surat repo/usecase
	suratRepo := repository.NewSuratRepository(db)
	suratUC := usecase.NewSuratUseCase(suratRepo)

	// Pengajuan repo/usecase
	pengajuanRepo := repository.NewPengajuanRepository(db)
	pengajuanUC := usecase.NewPengajuanUseCase(pengajuanRepo)

	// JWT & Auth
	jwtService := service.NewJwtService(cfg.TokenConfig)
	authMiddleware := middleware.NewAuthMiddleware(jwtService, userRepo)
	authUC := usecase.NewAuthenticationUseCase(userUC, jwtService)

	r := gin.Default()

	r.Use(cors.New(cors.Config{
		AllowAllOrigins:  true, // Untuk development, izinkan semua origin
		AllowMethods:     []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},
		AllowHeaders:     []string{"Origin", "Content-Type", "Accept", "Authorization"},
		AllowCredentials: false, // Set false untuk development dengan AllowAllOrigins
	}))

	delivery.RegisterWilayahRoutes(r, wilayahUC)
	delivery.RegisterRWRoutes(r, rwUC)
	delivery.RegisterRTRoutes(r, rtUC)
	delivery.RegisterKartuKeluargaRoutes(r, kkUC)
	delivery.RegisterWargaRoutes(r, wargaUC)
	delivery.RegisterSuratRoutes(r, suratUC)
	delivery.RegisterPengajuanRoutes(r, pengajuanUC)

	// Register Auth
	authGroup := r.Group("/api")
	authHandler := delivery.NewAuthHandler(authUC, authGroup)
	authHandler.Route()

	// Register User
	delivery.RegisterUserRoutes(r, userUC, authMiddleware)

	r.Run(":" + cfg.ApiPort)
}

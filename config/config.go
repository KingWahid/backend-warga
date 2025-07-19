package config

import (
	"fmt"
	"os"
	"time"

	"github.com/golang-jwt/jwt/v5"
	"github.com/joho/godotenv"
)

type DBConfig struct {
	Host     string
	Port     string
	Database string
	Username string
	Password string
	Driver   string
}

type APIConfig struct {
	ApiPort string
}

type TokenConfig struct {
	ApplicationName      string
	JwtSignatureKey      []byte
	JwtSigningMethod     *jwt.SigningMethodHMAC
	AccessTokenLifeTime  time.Duration
}


type Config struct {
	DBConfig
	APIConfig
	TokenConfig
}

func (c *Config) readConfig() error {
	fmt.Println("🟡 Starting to load config...")
	// Load .env
	if err := godotenv.Load(); err != nil {
		return fmt.Errorf("error loading .env file: %w", err)
	}

	// Debug log environment variables
fmt.Printf("🔍 DB_HOST: '%s'\n", os.Getenv("DB_HOST"))
fmt.Printf("🔍 DB_PORT: '%s'\n", os.Getenv("DB_PORT"))
fmt.Printf("🔍 DB_NAME: '%s'\n", os.Getenv("DB_NAME"))
fmt.Printf("🔍 DB_USER: '%s'\n", os.Getenv("DB_USER"))

	// Read durations
	accessDuration, err := time.ParseDuration(os.Getenv("ACCESS_TOKEN_LIFETIME"))
	if err != nil {
		return fmt.Errorf("invalid ACCESS_TOKEN_LIFETIME: %w", err)
	}

	// Setup configs
	c.DBConfig = DBConfig{
		Host:     os.Getenv("DB_HOST"),
		Port:     os.Getenv("DB_PORT"),
		Database: os.Getenv("DB_NAME"),
		Username: os.Getenv("DB_USER"),
		Password: os.Getenv("DB_PASSWORD"),
		Driver:   os.Getenv("DB_DRIVER"),
	}

	c.APIConfig = APIConfig{
		ApiPort: os.Getenv("API_PORT"),
	}

	c.TokenConfig = TokenConfig{
		ApplicationName:      "Siwarga",
		JwtSignatureKey:      []byte(os.Getenv("JWT_SIGNATURE_KEY")),
		JwtSigningMethod:     jwt.SigningMethodHS256,
		AccessTokenLifeTime:  accessDuration,
	}

	// Final validation
	if c.DBConfig.Host == "" || c.DBConfig.Port == "" || c.DBConfig.Username == "" || c.DBConfig.Password == "" || c.APIConfig.ApiPort == "" {
		return fmt.Errorf("missing required database or API config")
	}

	return nil
}

func NewConfig() (*Config, error) {
	cfg := &Config{}
	if err := cfg.readConfig(); err != nil {
		return nil, err
	}

		fmt.Printf("✅ Loaded config: DB=%s:%s, API Port=%s\n",
		cfg.Host, cfg.Port,
		cfg.ApiPort,
	)
	return cfg, nil
}

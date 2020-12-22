package app

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func messageRoute(c *gin.Context) {
	message := c.Param("message")
	c.String(http.StatusOK, message)
}

func noRoute(c *gin.Context) {
	c.String(http.StatusInternalServerError, "Wrong URI address")
}

func setupServer(port string) *gin.Engine {
	gin.SetMode(gin.ReleaseMode)
	r := gin.Default()

	r.GET("/:message", messageRoute)
	r.NoRoute(noRoute)

	return r
}

func RunServer(port string) {
	setupServer(port).Run()
}

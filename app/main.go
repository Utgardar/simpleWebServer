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

func setupServer(debug bool) *gin.Engine {
	if !debug {
		gin.SetMode(gin.ReleaseMode)
	}
	r := gin.Default()

	r.GET("/:message", messageRoute)
	r.NoRoute(noRoute)

	return r
}

func RunServer(port string, debug bool) {
	setupServer(debug).Run(":" + port)
}

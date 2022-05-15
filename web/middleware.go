package web

import (
	"busuanzi/config"
	"github.com/gin-gonic/gin"
)

func AccessControl() gin.HandlerFunc {
	return func(c *gin.Context) {
		c.Header("Access-Control-Allow-Origin", config.C.Web.AcAo)
		c.Header("Server", "busuanzi-by-xcsoft/1.9")
		if c.Request.Method == "OPTIONS" {
			c.Header("Access-Control-Allow-Methods", "GET,POST,HEAD,OPTIONS")
			c.Header("Access-Control-Allow-Headers", "x-bsz-referer")
			c.Header("Access-Control-Max-Age", "86400")
			c.AbortWithStatus(204)
			return
		}
	}
}

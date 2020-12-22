package app

import (
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/stretchr/testify/assert"
)

func performRequest(r http.Handler, method, path string) *httptest.ResponseRecorder {
	req, _ := http.NewRequest(method, path, nil)
	w := httptest.NewRecorder()
	r.ServeHTTP(w, req)
	return w
}

func Test_messageRoute(t *testing.T) {
	t.Run("Valid URI without redirect", func(t *testing.T) {
		router := setupServer("8765")
		w := performRequest(router, "GET", "/test")
		assert.Equal(t, http.StatusOK, w.Code)
		response := w.Body.String()
		assert.Equal(t, response, "test")
	})
	t.Run("Invalid URI", func(t *testing.T) {
		router := setupServer("8765")
		w := performRequest(router, "GET", "/test/test")
		assert.Equal(t, http.StatusInternalServerError, w.Code)
		response := w.Body.String()
		assert.Equal(t, response, "Wrong URI address")
	})
	t.Run("Valid URI with redirect", func(t *testing.T) {
		router := setupServer("8765")
		w := performRequest(router, "GET", "/test/")
		assert.Equal(t, http.StatusMovedPermanently, w.Code)
	})
}

package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

// album represents data about a record album.
type dummy struct {
	ID     string  `json:"id"`
	Title  string  `json:"title"`
	Artist string  `json:"artist"`
	Price  float64 `json:"price"`
}

// albums slice to seed record album data.
var dataDummy = []dummy{
	{ID: "1", Title: "Blue Train", Artist: "John Coltrane", Price: 56.99},
	{ID: "2", Title: "Jeru", Artist: "Gerry Mulligan", Price: 17.99},
	{ID: "3", Title: "Sarah Vaughan and Clifford Brown", Artist: "Sarah Vaughan", Price: 39.99},
}

var dataWeather = struct{ Status string }{Status: "OK"}

func main() {

	e := echo.New()
	// router := gin.Default()

	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	e.GET("/", func(c echo.Context) error {
		return c.HTML(http.StatusOK, "Hello, Docker! <3")
	})

	e.GET("/ping", func(c echo.Context) error {
		return c.JSON(http.StatusOK, struct{ Status string }{Status: "OK"})
	})

	e.GET("/weather", func(c echo.Context) error {
		return c.JSON(http.StatusOK, func.getWeather)
	})

	e.GET("/endpoint", func(c echo.Context) error {
		return c.JSON(http.StatusOK, dataDummy)
	})

	httpPort := os.Getenv("HTTP_PORT")
	if httpPort == "" {
		httpPort = "8080"
	}

	router := gin.Default()
	router.GET("/endpoint", getDummy)
	// router.GET("/wheather", getWeather)

	// router.Run("localhost:8080")

	e.Logger.Fatal(e.Start(":" + httpPort))
}

// getAlbums responds with the list of all albums as JSON.
func getDummy(c *gin.Context) {
	c.IndentedJSON(http.StatusOK, dataDummy)
}

func getWeather(c echo.Context) {
	url := "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&hourly=temperature_2m"
	req, err := http.NewRequest("GET", url, nil)
	if err != nil {
		fmt.Print(err.Error())
	}
	req.Header.Add("x-rapidapi-key", "YOU_API_KEY")
	res, err := http.DefaultClient.Do(req)
	if err != nil {
		fmt.Print(err.Error())
	}
	defer res.Body.Close()
	body, readErr := ioutil.ReadAll(res.Body)
	if readErr != nil {
		fmt.Print(err.Error())
	}
	c.JSON(http.StatusOK, string(body))

	fmt.Println(string(body))
}

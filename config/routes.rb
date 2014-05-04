CoordsToWeather::Application.routes.draw do
  get("/weather", { :controller => "coords", :action => "fetch_weather" })
  get("/weather/:location", { :controller => "coords", :action => "fetch_weather" })
end

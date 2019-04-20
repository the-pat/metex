defmodule Metex.Weather do
  def client(api_key) do
    middleware = [
      {Tesla.Middleware.BaseUrl, "https://api.openweathermap.org"},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Query, [appid: api_key]}
    ]

    Tesla.client(middleware)
  end

  def get_weather(client, location) do
    Tesla.get(client, "/data/2.5/weather", query: [q: location])
  end
end

defmodule Metex.Worker do
  alias Metex.Weather

  def temperature_of(api_key, location) do
    result =
      api_key
      |> Weather.client()
      |> Weather.get_weather(location)
      |> parse_response()

    case result do
      {:ok, temp} ->
        {:ok, location, temp}

      :error ->
        {:error, location}
    end
  end

  def parse_response({:ok, %Tesla.Env{status: 200, body: body}}) do
    temp =
      (body["main"]["temp"] - 273.15)
      |> Float.round(1)

    {:ok, temp}
  end

  def parse_response(_) do
    :error
  end
end

defmodule Metex.Worker do
  alias Metex.Weather

  @api_key Application.get_env(:metex, :weather_api_key)

  def loop() do
    receive do
      {sender_pid, location} ->
        send(sender_pid, {:ok, temperature_of(location)})

      _ ->
        IO.puts("I don't know how to process this message.")
    end

    loop()
  end

  defp temperature_of(location) do
    result =
      Weather.client(@api_key)
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

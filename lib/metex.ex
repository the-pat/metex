defmodule Metex do
  use Application

  def start(_type, _args) do
    children = [
      {Task.Supervisor, name: Metex.RequestSupervisor}
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end

  def temperatures_of(cities) do
    client =
      Application.get_env(:metex, :weather_api_key)
      |> Metex.Weather.client()

    cities
    |> Enum.map(
      &Task.Supervisor.async_nolink(Metex.RequestSupervisor, fn ->
        Metex.Weather.get_weather(client, &1)
        |> parse_response()
      end)
    )
    |> Task.yield_many(5000)
    |> Enum.map(fn {task, res} ->
      {:ok, weather} = res || Task.shutdown(task, :brutal_kill)

      weather
    end)
    |> Enum.sort()
  end

  defp parse_response({:ok, %Tesla.Env{status: 200, body: body}}) do
    temp =
      (body["main"]["temp"] - 273.15)
      |> Float.round(1)

    {:ok, body["name"], temp}
  end

  defp parse_response(_) do
    :error
  end
end

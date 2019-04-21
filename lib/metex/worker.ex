defmodule Metex.Worker do
  use GenServer
  alias Metex.Weather

  @api_key Application.get_env(:metex, :weather_api_key)
  @name Worker

  ## Client API

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts ++ [name: @name])
  end

  def get_temperature(location) do
    GenServer.call(@name, {:location, location})
  end

  def get_stats() do
    GenServer.call(@name, :get_stats)
  end

  def reset_stats() do
    GenServer.cast(@name, :reset_stats)
  end

  def stop() do
    GenServer.cast(@name, :stop)
  end

  ## Server Callbacks

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:location, location}, _from, stats) do
    case temperature_of(location) do
      {:ok, temp} ->
        new_stats = update_stats(stats, location)
        {:reply, {location, temp}, new_stats}

      _ ->
        {:reply, :error, stats}
    end
  end

  def handle_call(:get_stats, _from, stats) do
    {:reply, stats, stats}
  end

  def handle_cast(:reset_stats, _stats) do
    {:noreply, %{}}
  end

  def handle_cast(:stop, stats) do
    {:stop, :normal, stats}
  end

  def handle_info(msg, stats) do
    IO.puts("Received #{IO.inspect(msg)}")
    {:noreply, stats}
  end

  def terminate(reason, stats) do
    # We could write to a file, database etc
    IO.puts("Server terminated because of #{IO.inspect(reason)}")
    IO.inspect(stats)

    :ok
  end

  ## Helper Functions

  defp temperature_of(location) do
    Weather.client(@api_key)
    |> Weather.get_weather(location)
    |> parse_response()
  end

  defp parse_response({:ok, %Tesla.Env{status: 200, body: body}}) do
    temp =
      (body["main"]["temp"] - 273.15)
      |> Float.round(1)

    {:ok, temp}
  end

  defp parse_response(_) do
    :error
  end

  defp update_stats(old_stats, location) do
    case Map.has_key?(old_stats, location) do
      true ->
        Map.update!(old_stats, location, &(&1 + 1))

      false ->
        Map.put_new(old_stats, location, 1)
    end
  end
end

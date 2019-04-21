defmodule Metex do
  def temperatures_of(cities) do
    Metex.Worker.start_link()

    cities
    |> Task.async_stream(&Metex.Worker.get_temperature/1)
    |> Enum.map(fn {task, res} ->
      res || Task.shutdown(task, :brutal_kill)
    end)
    |> Enum.sort()
    |> Enum.to_list()
  end
end

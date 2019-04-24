# Metex

> Never wonder about the weather again. Or do. Your choice.

## Usage

1. Get an API key from [OpenWeatherMap](https://openweathermap.org/)
2. Create a secret config file called `config/config.secret.exs` with the contents

    ```elixir
    use Mix.Config

    config :metex, weather_api_key: <API_KEY>
    ```

3. Start `iex`:

    ```elixir
    iex> cities = ["Frankfurt", "Dallas", "Vranje", "Rome", "Tokyo", "Budapest", "Some Fake Place"]
    iex> cities |> Metex.temperatures_of()
    [
      {:ok, "Budapest", 21.5},
      {:ok, "Dallas", 15.9},
      {:ok, "Frankfurt", 25.0},
      {:ok, "Rome", 23.0},
      {:ok, "Tokyo", 18.4},
      {:ok, "Vranje", 22.0},
      {:error, "Some Fake Place", "city not found", "404"}
    ]
    ```
## Attribution

Example from chapter three and four of [The Little Elixir & OTP Guidebook](https://www.manning.com/books/the-little-elixir-and-otp-guidebook).

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

    ```
    iex> cities = ["Frankfurt", "Dallas", "Vranje", "Rome", "Tokyo", "Budapest"]
    iex> cities |> Metex.temperatures_of()
    [
      {"Budapest", 14.8},
      {"Dallas", 26.7},
      {"Frankfurt", 16.2},
      {"Rome", 16.6},
      {"Tokyo", 15.4},
      {"Vranje", 10.0}
    ]
    ```
## Attribution

Example from chapter three and four of [The Little Elixir & OTP Guidebook](https://www.manning.com/books/the-little-elixir-and-otp-guidebook).

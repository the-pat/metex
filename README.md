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
    :ok
    Budapest: 21.5°C, Dallas: 8.5°C, Frankfurt: 22.8°C, Rome: 21.1°C, Tokyo: 14.5°C, Vranje: 16.8°C
    ```
## Attribution

Example from chapter three of [The Little Elixir & OTP Guidebook](https://www.manning.com/books/the-little-elixir-and-otp-guidebook).

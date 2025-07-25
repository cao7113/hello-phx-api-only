defmodule HiWeb.ApiController do
  use HiWeb, :controller

  action_fallback(HiWeb.FallbackController)

  def home(conn, _params) do
    json(conn, %{
      msg: "Welcome from hello-phx-api-only!"
    })
  end

  def ping(conn, _params) do
    json(conn, %{
      msg: :pong,
      time: DateTime.utc_now()
    })
  end

  def info(conn, _params) do
    # TODO: need authorize or keep secret?
    info = %{
      build: Hi.build_info(),
      flyio: Flyinfo.env_vars(),
      distribution: Release.distribution()
    }

    json(conn, info)
  end

  def mock_404(_conn, _) do
    {:error, :not_found}
  end
end

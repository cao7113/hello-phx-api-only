defmodule Hi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HiWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:hi, :dns_cluster_query) || :ignore, log: :info},
      {Phoenix.PubSub, name: Hi.PubSub},
      # Start a worker by calling: Hi.Worker.start_link(arg)
      # {Hi.Worker, arg},
      # Start to serve requests, typically the last entry
      HiWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Hi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

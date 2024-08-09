defmodule BartWatch.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BartWatchWeb.Telemetry,
      BartWatch.Repo,
      {DNSCluster, query: Application.get_env(:bart_watch, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: BartWatch.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: BartWatch.Finch},
      # Start a worker by calling: BartWatch.Worker.start_link(arg)
      # {BartWatch.Worker, arg},
      # Start to serve requests, typically the last entry
      BartWatchWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BartWatch.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BartWatchWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

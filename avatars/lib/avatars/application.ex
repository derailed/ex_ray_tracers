defmodule Avatars.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    ExRay.Store.create

    children = [
      supervisor(AvatarsWeb.Endpoint, []),
    ]

    opts = [strategy: :one_for_one, name: Avatars.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    AvatarsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

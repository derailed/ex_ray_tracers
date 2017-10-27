defmodule TracemeWeb.CastleController do
  use TracemeWeb, :controller

  import Traceme.AvatarSvc, only: [get_avatar: 2]
  import Traceme.Spans

  alias Traceme.Avatar
  alias Traceme.ExRay.Phx

  use ExRay, pre: :start_span, post: :end_span

  @trace kind: :action
  def index(conn, _params) do
    req_id = conn   |> Phx.request_id
    p_span = req_id |> ExRay.Store.current

    castles = req_id
    |> Traceme.Castle.all
    |> Enum.map(fn(c) ->
      %{c | avatar: req_id |> Avatar.get_icon(p_span, c)}
    end)

    render conn, "index.json", castles: castles
  end

  @trace kind: :action
  def index_flow(conn, _params) do
    req_id  = conn   |> Phx.request_id
    p_span  = req_id |> ExRay.Store.current
    castles = req_id |> Traceme.Castle.all

    castles = castles
    |> Flow.from_enumerable
    |> Flow.partition(partitions: length(castles), hash: fn(c) -> {c, c.id - 1}end)
    |> Flow.reduce(fn -> [] end, fn(c, acc) ->
      acc ++ [%{c | avatar: req_id |> Avatar.get_icon(p_span, c)}]
    end)
    |> Enum.to_list()

    render conn, "index.json", castles: castles
  end

  @trace kind: :action
  def index_svc(conn, _params) do
    req_id  = conn |> Phx.request_id
    p_span  = ExRay.Store.current(req_id)
    pid     = p_span |> ExRay.Span.parent_id
    castles = req_id |> Traceme.Castle.all

    castles = castles
    |> Flow.from_enumerable
    |> Flow.partition(partitions: length(castles), hash: fn(c) -> {c, c.id - 1}end)
    |> Flow.reduce(fn -> [] end, fn(c, acc) ->
      acc ++ [%{c | avatar: pid |> get_avatar(c.name)}]
    end)
    |> Enum.to_list()

    render conn, "index.json", castles: castles
  end
end

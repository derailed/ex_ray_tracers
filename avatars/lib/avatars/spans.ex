defmodule Avatars.Spans do
  alias Avatars.ExRay.Phx

  def start_span(ctx) do
    conn     = ctx.args |> List.first
    req_id   = conn     |> Phx.request_id
    args     = ctx.args |> List.last
    {pid, _} = Integer.parse(args["span_id"])

    conn
    |> Phx.span_name
    |> ExRay.Span.open(req_id, pid)
    |> :otter.tag(:kind, ctx.meta[:kind])
    |> :otter.tag(:controller, conn |> Phx.controller_name)
    |> :otter.tag(:action    , conn |> Phx.action_name)
    |> :otter.log(">>> Starting action `#{conn |> Phx.action_name} at #{conn.request_path}")
  end

  def end_span(ctx, span, _rendered) do
    conn   = ctx.args |> List.first
    req_id = conn     |> Phx.request_id

    span
    |> IO.inspect
    |> :otter.log("<<< Ending action `#{conn |> Phx.action_name}")
    |> ExRay.Span.close(req_id)
  end
end

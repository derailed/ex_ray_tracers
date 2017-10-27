defmodule Traceme.Spans do
  alias ExRay.Span
  alias Traceme.ExRay.Phx

  def start_span(ctx) do
    conn = ctx.args |> List.first

    conn
    |> Phx.span_name
    |> Span.open(conn |> Phx.request_id)
    |> :otter.tag(:kind, ctx.meta[:kind])
    |> :otter.tag(:controller, conn |> Phx.controller_name)
    |> :otter.tag(:action    , conn |> Phx.action_name)
    |> :otter.log(">>> Starting action `#{conn |> Phx.action_name} at #{conn.request_path}")
  end

  def end_span(ctx, span, _rendered) do
    conn = ctx.args |> List.first

    span
    |> :otter.log("<<< Ending action `#{conn |> Phx.action_name}")
    |> Span.close(conn |> Phx.request_id)
  end
end
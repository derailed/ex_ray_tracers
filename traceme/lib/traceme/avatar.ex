defmodule Traceme.Avatar do
  use ExRay, pre: :pre_call, post: :post_call

  @trace kind: :function
  def get_icon(_req_id, _p_span, castle) do
    :timer.sleep(500)

    castle.name
    av = castle.name
    |> String.replace(" ", "")
    |> String.downcase
    |> Macro.underscore
    av <> ".png"
  end

  defp pre_call(ctx) do
    ctx.target
    |> ExRay.Span.open(ctx.args |> List.first, ctx.args |> Enum.at(1))
  end

  defp post_call(ctx, p_span, _res) do
    p_span |> ExRay.Span.close(ctx.args |> List.first)
  end
end

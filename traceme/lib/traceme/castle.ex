defmodule Traceme.Castle do
  use ExRay

  alias Traceme.Repo
  alias Traceme.Store.Castle
  alias ExRay.Span
  alias Traceme.ExRay.Ecto

  require Logger

  @trace pre: :pre_fun, post: :post_fun
  def all(req_id) do
    req_id |> all_castles
  end

  defp pre_fun(ctx) do
    ctx.target
    |> Span.open(ctx.args |> List.first)
  end

  defp post_fun(ctx, p_span, _ret) do
    p_span |> ExRay.Span.close(ctx.args |> List.first)
  end

  @trace query: :all_castles, pre: :pre_ecto, post: :post_ecto
  def all_castles(_req_id) do
    Castle |> Repo.all
  end

  defp pre_ecto(ctx) do
    :ecto
    |> Span.open(ctx.args |> List.first)
    |> :otter.tag(:query, ctx.meta[:query])
    |> :otter.log(Ecto.to_query(:all, Repo, Castle))
  end

  defp post_ecto(ctx, p_span, _ret) do
    p_span |> Span.close(ctx.args |> List.first)
  end
end

defmodule Traceme.ExRay.Ecto do
  @doc """
  Convenience to retrieve the current Ecto query as a string
  """
  @spec to_query(String.t, Ecto.Repo.t, Ecto.Query.t) :: String.t
  def to_query(kind, repo, queryable) do
    {q, _} = repo.to_sql(kind, queryable)
    q |> String.replace("\"", "")
  end
end

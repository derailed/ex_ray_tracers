defmodule Traceme.AvatarSvc do
  require Logger

  @avatar_url "http://localhost:4005/api/gen_icon"

  def get_avatar(id, name) do
    %{"avatar" => av} = get!("#{@avatar_url}?span_id=#{id}&name=#{name |> URI.encode}")
    av
  end

  defp get!(url) do
    url
    |> HTTPoison.get!([], timeout: 30_000, recv_timeout: 30_000)
    |> decode!
  end

  defp decode!(%HTTPoison.Response{body: body}) do
    body |> Poison.Parser.parse!
  end
end
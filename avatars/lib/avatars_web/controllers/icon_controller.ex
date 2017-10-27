defmodule AvatarsWeb.IconController do
  use AvatarsWeb, :controller

  import Avatars.Spans

  use ExRay, pre: :start_span, post: :end_span

  @trace kind: :action
  def gen_icon(conn, %{"span_id" => _span, "name" => name}) do
    av = name
    |> String.replace(" ", "")
    |> String.downcase
    |> Macro.underscore

    # Sim image generation...
    :timer.sleep(500)

    render conn, "index.json", avatar: av <> ".png"
  end
end

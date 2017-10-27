defmodule TracemeWeb.CastleView do
  use TracemeWeb, :view

  def render("index.json", %{castles: castles}) do
    %{castles: render_many(castles, TracemeWeb.CastleView, "castle.json")}
  end

  def render("castle.json", %{castle: castle}) do
    %{
      id:   castle.id,
      name: castle.name,
      avatar: castle.avatar
    }
  end
end


defmodule AvatarsWeb.IconView do
  use AvatarsWeb, :view

  def render("index.json", %{avatar: avatar}) do
    %{avatar: avatar}
  end
end

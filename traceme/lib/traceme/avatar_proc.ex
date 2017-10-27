defmodule Traceme.AvatarProc do
  use GenServer

  use ExRay, pre: :start, post: :stop

  def init(state), do: {:ok, state}

  @trace kind: :remote_function
  def handle_call({:get_avatar, p_span, castle}, _from, state) do

    :timer.sleep(1_000)

    {:reply, castle.name, state}
  end

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def get_avatar(p_span, castle) do
    IO.puts "!!!! IN App Avatar get_avatar !!!"
    GenServer.call(__MODULE__, {:get_avatar, p_span, castle})
  end

  defp start(ctx) do
    args = ctx.args |> List.first

    :get_avatar
    |> :otter.start(args |> elem(1))
    |> :otter.tag(:kind, ctx.meta[:kind])
  end

  defp stop(ctx, span, _res) do
    args = ctx.args |> List.first
    span
    |> :otter.log("Getting avatar from service for #{(args |> elem(2)).name}")
    |> :otter.finish()
  end
end

defmodule Traceme.Plug do
  def trace_me(conn, _) do
    root_span = conn
    |> span_name
    |> :otter.start
    |> :otter.log("Starting request #{conn.request_path}")

     conn |> Plug.Conn.assign(:root_span, root_span)
  end

  defp span_name(conn) do
    "#{(conn.scheme |> Atom.to_string |> String.upcase)} #{conn.method} #{conn.request_path}"
  end
end
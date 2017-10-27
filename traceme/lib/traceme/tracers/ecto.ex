defmodule Traceme.Tracers.Ecto do
  require Logger

  defmacro __using__(_opts) do
    # module_name = __CALLER__.module
    quote do
      def setup do
        Logger.info("!!!!!!!!!!!! Ecto Tracer Setup !!!!!!!!!!!!!!!")
      end

      def log(entry) do
        Logger.info("!!!!!!!!!!! ECTO Logging Entry")
        Logger.info("Q: #{entry.query}")

        entry |> IO.inspect
      end
    end
  end
end
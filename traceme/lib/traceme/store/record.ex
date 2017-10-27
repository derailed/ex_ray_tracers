defmodule Traceme.Record do
  @moduledoc false

  defmacro __using__(_) do
    quote do
      use Ecto.Schema

      import Ecto.Changeset
      import Ecto.Query

      alias Traceme.Repo

      @doc """
      Clear out all records
      """
      @spec clear() :: {integer, nil | [term]} | no_return
      def clear() do
        Repo.delete_all(__MODULE__)
      end
    end
  end
end

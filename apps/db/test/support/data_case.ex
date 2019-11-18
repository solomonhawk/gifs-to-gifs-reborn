defmodule GifMe.DB.DataCase do
  use ExUnit.CaseTemplate

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(GifMe.DB.Repo)
  end

  using do
    quote do
      import Ecto.Changeset

      defp errors_on(changeset) do
        normalized_errors(changeset)
      end

      defp errors_on(model, data) do
        normalized_errors(model.__struct__.changeset(model, data))
      end

      defp normalized_errors(changeset) do
        traverse_errors(changeset, fn {msg, opts} ->
          Enum.reduce(opts, msg, fn {key, value}, acc ->
            String.replace(acc, "%{#{key}}", to_string(value))
          end)
        end)
      end
    end
  end
end

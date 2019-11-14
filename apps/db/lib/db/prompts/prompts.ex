defmodule GifMe.DB.Prompts do
  alias GifMe.DB.Repo
  alias GifMe.DB.Prompts.Prompt

  def create_prompt(attrs \\ %{}) do
    Prompt.changeset(%Prompt{}, attrs)
    |> Repo.insert()
  end
end

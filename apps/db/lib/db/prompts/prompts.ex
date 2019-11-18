defmodule GifMe.DB.Prompts do
  alias GifMe.DB.Repo
  alias GifMe.DB.Prompts.Prompt

  def create_prompt(attrs \\ %{}) do
    %Prompt{}
    |> Prompt.changeset(attrs)
    |> Repo.insert()
  end

  def update_prompt(prompt, attrs \\ %{}) do
    prompt
    |> Prompt.changeset(attrs)
    |> Repo.update()
  end

  def find_prompt(attrs \\ %{}) do
    Repo.get_by(Prompt, attrs)
  end

  def all() do
    Repo.all(Prompt)
  end
end

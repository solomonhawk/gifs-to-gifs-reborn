defmodule GifMe.Ui.PromptController do
  use GifMe.Ui, :controller

  alias GifMe.DB.Prompts
  alias GifMe.DB.Prompts.Prompt

  def index(conn, _params) do
    prompts = Prompts.all()
    render(conn, "index.html", prompts: prompts)
  end

  def new(conn, _params) do
    changeset = Prompt.changeset(%Prompt{})
    render(conn, "new.html", changeset: changeset)
  end

  def show(conn, %{"id" => id}) do
    prompt = Prompts.find_prompt(id: id)
    render(conn, "show.html", prompt: prompt)
  end

  def edit(conn, %{"id" => id}) do
    prompt = Prompts.find_prompt(id: id)
    changeset = Prompt.changeset(prompt)
    render(conn, "edit.html", prompt: prompt, changeset: changeset)
  end

  def create(conn, %{"prompt" => prompt_params}) do
    case Prompts.create_prompt(prompt_params) do
      {:ok, prompt} ->
        conn
        |> put_flash(:info, "Prompt created")
        |> render("show.html", prompt: prompt)

      {:error, changeset} ->
        conn
        |> render("new.html", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "prompt" => prompt_params}) do
    prompt = Prompts.find_prompt(id: id)

    case Prompts.update_prompt(prompt, prompt_params) do
      {:ok, prompt} ->
        conn
        |> put_flash(:info, "Prompt updated")
        |> render("show.html", prompt: prompt)

      {:error, changeset} ->
        conn
        |> render("edit.html", changeset: changeset)
    end
  end
end

defmodule GifMe.DBTest do
  use ExUnit.Case
  doctest GifMe.DB

  test "greets the world" do
    assert GifMe.DB.hello() == :world
  end
end

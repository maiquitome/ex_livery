defmodule ExLiveryTest do
  use ExUnit.Case
  doctest ExLivery

  test "greets the world" do
    assert ExLivery.hello() == :world
  end
end

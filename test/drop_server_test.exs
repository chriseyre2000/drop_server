defmodule DropServerTest do
  use ExUnit.Case
  doctest DropServer

  test "greets the world" do
    assert DropServer.hello() == :world
  end
end

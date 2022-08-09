defmodule CodingApeTest do
  use ExUnit.Case
  doctest CodingApe

  test "greets the world" do
    assert CodingApe.hello() == :world
  end
end

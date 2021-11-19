defmodule DayOneTest do
  use ExUnit.Case
  import DayOne

  test "two numbers 2020" do
    assert is2020(0, 0) == :error
    assert is2020(2015, 5) == [2015, 5]
  end

  test "find pair that equals 2020" do
    assert find_2020([2019, 1]) == [2019, 1]
    assert find_2020([2019, 1, 0]) == [2019, 1]
    assert find_2020([0, 2019, 1]) == [2019, 1]
    assert find_2020([2019, 0, 1]) == [2019, 1]
    assert find_2020([2019, 0, 0, 1]) == [2019, 1]
    assert find_2020([0, 2019, 0, 1]) == [2019, 1]
  end

  test "find pair from file" do
    assert find_pair_from_file("priv/testinput.txt") == [1,2019]
  end

  test "calculate from file" do
    assert calculate("priv/testinput.txt") == 2019
  end

  test "calculate from input" do
    calculate("priv/dayoneinput.txt") |> IO.puts
  end
end

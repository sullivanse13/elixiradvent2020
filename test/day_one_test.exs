defmodule DayOneTest do
  use ExUnit.Case
  import DayOne

  test "two numbers 2020" do
    assert is_target(2020, 0, 0) == :error
    assert is_target(2020, 2015, 5) == [2015, 5]
  end

  test "find pair that equals 2020" do
    assert find_2020([2019, 1]) == [2019, 1]
    assert find_2020([2019, 1, 0]) == [2019, 1]
    assert find_2020([0, 2019, 1]) == [2019, 1]
    assert find_2020([2019, 0, 1]) == [2019, 1]
    assert find_2020([2019, 0, 0, 1]) == [2019, 1]
    assert find_2020([0, 2019, 0, 1]) == [2019, 1]
  end

  test "find pair that equals 2019" do
    assert find_target(2019, [0, 2018, 0, 1]) == [2018, 1]
  end

  test "calculate from file" do
    assert calculate("priv/testinput.txt") == 2019
  end

  test "calculate from input" do
    IO.puts("\n pair product is #{calculate("priv/dayoneinput.txt")}\n")
  end

  test "find triplet that is 2020" do
    assert find_triplet_2020([2018, 1, 1]) == [2018, 1, 1]
    assert find_triplet_2020([2018, 1, 1, 0]) == [2018, 1, 1]
    assert find_triplet_2020([0, 2018, 1, 1]) == [2018, 1, 1]
    assert find_triplet_2020([0, 2018, 1, 0, 1]) == [2018, 1, 1]
  end

  test "triplet_from_file" do
    assert triplet_product_from_file("priv/testinput_3.txt") == 2018
  end

  test "calculate triplet_product_from_file input triplet" do
    IO.puts(
      "\n triplet_product_from_file is #{triplet_product_from_file("priv/dayoneinput.txt")}\n"
    )
  end
end

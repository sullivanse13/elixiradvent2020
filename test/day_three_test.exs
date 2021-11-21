defmodule DayThreeTest do
  use ExUnit.Case
  import DayThree


  test "count hit trees from day three input" do
    IO.puts("\ntrees hit #{count_hit_trees_from_file("priv/day_three_input.txt")}\n")
  end

  # read rows from file
  test "count hit trees from file" do
    assert count_hit_trees_from_file("priv/day_three_input_test.txt") == 2
  end


  test "count trees hit over multiple rows" do

    assert count_hit_trees(num_rows(1)) == 0
    #".#.#"
    #".#.#"
    assert count_hit_trees(num_rows(2)) == 1
    #"O#.#"
    #".#.X"
    #".#.#.#O#"
    #".#.#.#.#.X.#"
    assert count_hit_trees(num_rows(4)) == 2
    #".#.#.#.#.#.#O#.#"
    assert count_hit_trees(num_rows(5)) == 2
  end

  defp num_rows(num_rows) do
    test_row = [".#.#"]
    Enum.take(Stream.cycle(test_row), num_rows)
  end


  test "generate coordinates" do
    assert  Enum.take(coordinates(), 1) == [0]
    assert  Enum.take(coordinates(), 3) == [0,3,6]
  end

  test "is nth place a tree" do
    row = ".#.#"
    assert is_tree(row, 0) == false
    assert is_tree(row, 1) == true
    # ".#.#.#.#
    assert is_tree(row, 4) == false
    assert is_tree(row, 5) == true
  end

  # x- generate slope coordinates
  # X - have row run out to right forever
  # X - test nth item in a row for a tree
  # X - test if place on row is tree
  # X -count trees hit over multiple rows


end

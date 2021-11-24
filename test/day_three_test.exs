defmodule DayThreeTest do
  use ExUnit.Case
  import DayThree

  # [_]

  test "count specific slope" do
    assert count_hit_trees({3,1}, num_rows(4)) == 2

    assert count_hit_trees({1,1}, num_rows(4)) == 2
    assert count_hit_trees({2,1}, num_rows(4)) == 0
    #"O#.#"
    #".#.#"
    #".X.#.#.#"
    #".#.#.#.#.#.#"
    assert count_hit_trees({1,2}, num_rows(4)) == 1

  end


  test "product list of slopes" do
    slopes = [{3,1}, {1,1}, {1,2}]

    assert product_of_trees_hit_per_slope(num_rows(4), slopes) == 4

  end


  test "product of hit trees per slope from day three input" do
    slopes = [{1,1},{3,1},{5,1},{7,1},{1,2}]
    product = file_based_product_of_trees_hit_per_slope("priv/day_three_input.txt", slopes)
    IO.puts("\nproduct trees hit #{product}\n")
  end


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
    assert Enum.take(coordinates(), 1) == [0]
    assert Enum.take(coordinates(), 3) == [0,3,6]
    assert Enum.take(coordinates(2), 3) == [0,2,4]
  end

  test "is nth place a tree" do
    row = ".#.#"
    assert is_tree(row, 0) == false
    assert is_tree(row, 1) == true
    # ".#.#.#.#
    assert is_tree(row, 4) == false
    assert is_tree(row, 5) == true
  end

  # [x] generate slope coordinates
  # [x] have row run out to right forever
  # [x] test nth item in a row for a tree
  # [x] test if place on row is tree
  # [x] count trees hit over multiple rows
  # [x] count from specified slope (start with right 3, down 1)
  # [x] count from right 1x down 1 slope
  # [x] count from set of slopes
  # [x] product from set of slopes



end

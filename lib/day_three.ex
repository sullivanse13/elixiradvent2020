defmodule DayThree do
  @moduledoc false


  def file_based_product_of_trees_hit_per_slope(file_name, slopes) do
    file_name
    |> Utilities.read_file_to_list_of_strings()
    |> product_of_trees_hit_per_slope(slopes)
  end


  def product_of_trees_hit_per_slope(rows, slopes) do

    slopes
    |> Enum.map(fn s -> count_hit_trees(s, rows) end)
    |> Enum.product
  end

  def count_hit_trees_from_file(file_name) do

    file_name
    |> Utilities.read_file_to_list_of_strings()
    |> count_hit_trees()
  end

  def count_hit_trees({right, down}, rows) do
    rows
    |> Enum.take_every(down)
    |> Enum.zip(coordinates(right))
    |> Enum.count(fn {row, column} -> is_tree(row, column) end)
  end

  def count_hit_trees(rows) do
    rows
    |> Enum.zip(coordinates())
    |> Enum.count(fn {row, column} -> is_tree(row, column) end)
  end


  def coordinates(r \\ 3 ) do
    Stream.iterate(0, &(&1 + r))
  end


  def is_tree(row_sring, column) when is_binary(row_sring) do

    row_sring
    |> String.codepoints
    |> Stream.cycle
    |> is_tree(column)
  end

  def is_tree(row, column) do
    case Enum.at(row, column) do
      "." -> false
      "#" -> true
    end
  end
end

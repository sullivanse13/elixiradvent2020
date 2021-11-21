defmodule DayThree do
  @moduledoc false

  def count_hit_trees_from_file(file_name) do

    file_name
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> count_hit_trees()

  end

  def count_hit_trees(rows) do
    rows
    |> Enum.zip(coordinates())
    |> Enum.count(fn {row, column} -> is_tree(row, column) end)
  end

  def coordinates() do
    Stream.iterate(0, &(&1 + 3))
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

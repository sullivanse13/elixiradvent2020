defmodule DayOne do
  @moduledoc false

  def is_target(target, x,y) do
    case (x+y) do
      ^target -> [x,y]
      _ -> :error
    end
  end

  def find_2020(list) do
    find_target(2020, list)
  end

  def find_target(target, [x,y]), do: is_target(target, x,y)

  def find_target(target, [x|tl]) do
    case for n <- tl, (n+x) == target, do: n do
      [y] -> [x,y]
      [] -> find_target(target, tl)
    end
  end


  def calculate(file) do
    file
    |> find_product_from_file(&find_2020/1)
  end
  def triplet_product_from_file(file) do
    file
    |> find_product_from_file(&find_triplet_2020/1)
  end

  def find_product_from_file(file, find_func) do
    file
    |> Utilities.read_file_to_list_of_strings
    |> Enum.map(&String.to_integer/1)
    |> find_func.()
    |> Enum.product()
  end



  def find_triplet_2020([x | tl]) do
    diff = 2020-x
    case find_target(diff, tl) do
      :error -> find_triplet_2020(tl)
      [y,z] -> [x,y,z]
    end

  end


end

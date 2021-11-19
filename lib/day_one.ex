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
    case find_target(target, x,tl) do
      [x,y] -> [x,y]
      :error -> find_target(target, tl)
    end
  end

  def find_target(_, _,[]), do: :error
  def find_target(target, x,[y|tl]) do
    case is_target(target, x,y) do
      [x,y] -> [x,y]
      :error -> find_target(target, x,tl)
    end
  end

  def find_pair_from_file(file) do
    File.read!(file)
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> find_2020
  end

  def calculate(file) do
    file
    |> find_product_from_file(&find_2020/1)
  end

  def find_product_from_file(file, find_func) do
    file
    |> File.read!()
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> find_func.()
    |> Enum.product()
  end

  def triplet_product_from_file(file) do
    file
    |> find_product_from_file(&find_triplet_2020/1)
  end

  def find_triplet_2020([x | tl]) do
    diff = 2020-x
    case find_target(diff, tl) do
      :error -> find_triplet_2020(tl)
      [y,z] -> [x,y,z]
    end

  end


end

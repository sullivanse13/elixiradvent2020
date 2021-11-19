defmodule DayOne do
  @moduledoc false

  def is2020(x,y) do
    case (x+y) do
      2020 -> [x,y]
      _ -> :error
    end
  end

  def find_2020([x,y]), do: is2020(x,y)
  def find_2020([x|tl]) do
    case find_2020(x,tl) do
      [x,y] -> [x,y]
      :error -> find_2020(tl)
    end
  end

  def find_2020(_,[]), do: :error
  def find_2020(x,[y|tl]) do
    case is2020(x,y) do
      [x,y] -> [x,y]
      :error -> find_2020(x,tl)
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
    |> find_pair_from_file
    |> Enum.product
  end

end

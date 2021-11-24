defmodule DayTwoTest do
  use ExUnit.Case
  import DayTwo

  #
  # _ parse line
  # _ parse range in line
  # _ count required letter in password
  # _ check if count is in range
  #

  test "parse line" do
    assert parse_line_range("1-3 a: abcde") == {1..3, "a", "abcde"}
  end

  test "count required" do
    assert count_required_range("a", "abcde") == 1
    assert count_required_range("c", "acbcdec") == 3
  end

  test "is valid password" do
    assert is_valid_password_range({1..3, "a", "abcde"})
    refute is_valid_password_range({1..3, "b", "cdefg"})
    assert is_valid_password_range({2..9, "c", "ccccccccc"})
  end

  test "count valid in list" do
    list = ["1-3 a: abcde", "1-3 b: cdefg", "2-9 c: ccccccccc"]

    assert count_valid_passwords_range(list) == 2
  end

  test "count from file range" do
    assert count_valid_passwords_range("priv/day_two_input_test.txt") == 2
  end

  test "from input count of valid by range" do
    IO.puts(
      "\nvalid password count range: #{count_valid_passwords_range("priv/day_two_input.txt")}\n"
    )
  end

  test "count from file position" do
    assert count_valid_passwords_position("priv/day_two_input_test.txt") == 1
    assert count_valid_passwords_position("priv/day_two_input.txt") > 389
  end

  test "is valid positional" do
    assert is_valid_positional(["1", "3", "a", "abcde"])
    refute is_valid_positional(["1", "3", "b", "cdefg"])
    refute is_valid_positional(["2", "9", "c", "ccccccccc"])
  end

  test "from input count of valid by position" do
    IO.puts(
      "\nvalid password count position: #{count_valid_passwords_position("priv/day_two_input.txt")}\n"
    )
  end
end

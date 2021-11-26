defmodule DayFourTest do
  use ExUnit.Case
  import DayFour

  test "count valid passports in file" do
    assert count_valid_from_file("priv/day_four_input_test.txt") == 2
  end

  test "count valid passports in input" do
    "valid passorts #{count_valid_from_file("priv/day_four_input.txt")}\n"
    |> IO.puts()
  end

  test "zero valid passports in test file" do
    assert count_valid_from_file("priv/day_four_input_test_4_invlid_passwords.txt") == 0
  end

  test "4 valid passports in test file" do
    assert count_valid_from_file("priv/day_four_input_test_4_valid_passwords.txt") == 4
  end

  @passport_one %{
    "ecl" => "gry",
    "pid" => "860033327",
    "eyr" => "2020",
    "hcl" => "#fffffd",
    "byr" => "1937",
    "iyr" => "2017",
    "cid" => "147",
    "hgt" => "183cm"
  }

  @passport_two %{
    "ecl" => "amb",
    "pid" => "028048884",
    "eyr" => "2023",
    "hcl" => "#cfa07d",
    "byr" => "1929",
    "iyr" => "2013",
    "cid" => "350"
  }

  test "validate birth year", do: assert_field_validation("byr", ["2003", "1919"])
  test "validate issue year", do: assert_field_validation("iyr", ["2009", "2021"])
  test "validate expiration year", do: assert_field_validation("eyr", ["2019", "2031"])
  test "validate passport id", do: assert_field_validation("pid", ["01234567", "0123456789"])
  test "validate hair color", do: assert_field_validation("hcl", ["#123abz", "#123abz"])
  test "validate eye color", do: assert_field_validation("ecl", ["zzz", "xyz"])

  test "validate height color",
    do: assert_field_validation("hgt", ["149cm", "194cm", "190", "58in", "77in"])

  @docp """
  TDD todo list

  [x] stop having to handle not found error for everything?
  [x] validate height (cm, in)
  [x] validate eye color
  [x] validate hair color
  [x] validate birth year
  [x] validate issue year
  [x] validate expiration year
  [x] validate passport id
  [x] count valid passports in file
  [x] CHECK FOR Required fields
    byr (Birth Year)
    iyr (Issue Year)
    eyr (Expiration Year)
    hgt (Height)
    hcl (Hair Color)
    ecl (Eye Color)
    pid (Passport ID)
    cid (Country ID)
  [x] valid of only missing cid (north pole credential)
  [x] Read passport
  [x] Read multiple passports
  """

  defp assert_field_validation(key, invalids) do
    assert valid_passport?(@passport_one) == true

    assert valid_passport?(Map.drop(@passport_one, [key])) == false,
           "should have failed with dropped key: #{key}"

    invalids
    |> Enum.map(fn i ->
      assert valid_passport?(Map.put(@passport_one, key, i)) == false,
             "key: #{key} should fail with #{i}"
    end)
  end

  test "validate passport" do
    assert valid_passport?(@passport_one) == true
    assert valid_passport?(@passport_two) == false
    assert valid_passport?(Map.drop(@passport_one, ["cid"])) == true
  end

  test "read passport" do
    test_passport = """
    ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
    byr:1937 iyr:2017 cid:147 hgt:183cm
    """

    assert read_passport(test_passport) == @passport_one
  end

  test "read multiple passport" do
    test_passports = """
    ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
    byr:1937 iyr:2017 cid:147 hgt:183cm

    iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
    hcl:#cfa07d byr:1929
    """

    assert read_passports(test_passports) == [
             @passport_one,
             @passport_two
           ]
  end
end

defmodule Solution do

  def convert([]) do
    []
  end

  def convert([nil | tail]) do
    convert(tail)
  end

  def convert([head | tail]) do
    nums = ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']
    if isNumber(head) do
      [head | convert(tail)]
    else
      cond do
        Enum.take([head | tail], 3) in nums ->
          t = Enum.take([head | tail], 3)
          idx = Enum.find_index(nums, fn x -> x == t end)
          [idx + 48 | convert(Enum.drop(tail, 1))]
        Enum.take([head | tail], 4) in nums ->
          t = Enum.take([head | tail], 4)
          idx = Enum.find_index(nums, fn x -> x == t end)
          [idx + 48 | convert(Enum.drop(tail, 2))]
        Enum.take([head | tail], 5) in nums ->
          t = Enum.take([head | tail], 5)
          idx = Enum.find_index(nums, fn x -> x == t end)
          [idx + 48 | convert(Enum.drop(tail, 3))]
        true ->
          convert(tail)
      end
    end
  end

  def isNumber(x) do
    (x - hd('0')) in 0..9
  end

  def findNumberFromStart([head | tail]) do
    if isNumber(head) do
      head
    else
      findNumberFromStart(tail)
    end
  end

  def findNumberFromEnd([head | []]) do
    head
  end

  def findNumberFromEnd([head | tail]) do
    x = findNumberFromEnd(tail)
    if isNumber(x) do
      x
    else head end
  end

  def find(inList) do
    inList = convert(inList)
    #IO.puts(inList)
    (findNumberFromStart(inList) - 48) * 10 + findNumberFromEnd(inList) - 48
  end

  def run() do
    {:ok, data} = File.read("data.txt")
    data
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> find(String.to_charlist(x)) end)
    |> Enum.reduce(fn (x,y) -> x+y end)
  end
end

#testStr = "oneight" |> String.to_charlist()
#IO.puts(Solution.find(testStr))
IO.puts(Solution.run())

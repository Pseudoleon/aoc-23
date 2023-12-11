defmodule Solution do

  def convert([]) do
    []
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

IO.puts(Solution.run()) # 55621

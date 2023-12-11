defmodule Solution do
  @mred 12
  @mgreen 13
  @mblue 14

  def parse_line(line) do
    line
    |> String.split(": ")
    |> tl()
    |> hd()
    |> String.split(";")
    |> Enum.map(&parse_moves/1)
  end

  defp parse_moves(move_str) do
    move_str
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&parse_move/1)
  end

  defp parse_move(move) do
    [count_str, color] =
      move
      |> String.trim()
      |> String.split(" ")
    {String.to_integer(count_str), String.to_atom(color)}
  end

  defp check_subround({count, colour}) do
    cond do
      colour == :red ->
        [count, 0,0]
      colour == :blue ->
        [0,count,0]
      colour == :green ->
        [0,0,count]
      true -> true
    end
  end

  defp check_round2([], val) do
    val
  end

  defp listmax([a1,a2,a3], [b1,b2,b3]) do
    [max(a1,b1), max(a2,b2), max(a3,b3)]
  end

  defp check_round2([head | tail], [a,b,c]) do
    l = check_subround(head)
    check_round2(tail, listmax([a,b,c], l))
  end

  defp check_game([], vals) do
    vals
  end

  defp check_game([head | tail], vals) do
    x = check_round2(head, vals)
    #IO.inspect(x)
    check_game(tail, x)
  end

  def run_line(line) do
    parse_line(line)
    |> check_game([0,0,0])
  end

  defp finish([], acc, sum) do
    sum
  end

  defp finish([head | tail], acc, sum) do
    [a,b,c] = run_line(head)
    finish(tail, acc+1, sum + a*b*c)
  end

  def run() do
    {:ok, data} = File.read("data.txt")
    data
    |> String.split("\n", trim: true)
    |> finish(1,0)
  end

end

input_line = "Game 1: 13 red, 18 green; 5 green, 3 red, 5 blue; 5 green, 9 red, 6 blue; 3 blue, 3 green"
parsed_moves = Solution.parse_line(input_line)
IO.inspect(parsed_moves)

#parsed_moves = Solution.run_line(input_line)
#IO.inspect(parsed_moves)

IO.inspect(Solution.run_line(input_line)) # 2449
IO.inspect(Solution.run()) # 63981

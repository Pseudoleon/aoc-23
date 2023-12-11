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
        count <= @mred
      colour == :blue ->
        count <= @mblue
      colour == :green ->
        count <= @mgreen
      true -> true
    end
  end

  defp check_round([]) do
    true
  end

  defp check_round([head | tail]) do
    check_round(tail) and check_subround(head)
  end

  defp check_game([]) do
    true
  end

  defp check_game([head | tail]) do
    check_game(tail) and check_round(head)
  end

  def run_line(line) do
    parse_line(line)
    |> check_game()
  end

  defp finish([], acc, sum) do
    sum
  end

  defp finish([head | tail], acc, sum) do
    if run_line(head) do
      finish(tail, acc+1, sum + acc)
    else
      finish(tail, acc+1, sum)
    end
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

IO.puts(Solution.run()) # 2449

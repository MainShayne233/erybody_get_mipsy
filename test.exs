[
  {"problem_1.s", "233168"},
  {"problem_2.s", "4613732"},
  {"problem_3.s", "	6857"},
]
|> Enum.map(fn {file, solution} ->
  with {result, 0} <- System.cmd("spim", ["-f", "src/" <> file]),
       [_stuff, answer] <- String.split(result, "exceptions.s\n") do
    if answer == solution do
      IO.puts("#{file}: #{answer} is correct! ✅")
      :correct
    else
      IO.puts("#{file}: #{answer} is not correct! 😓")
      :incorrect
    end
  else
    _ ->
      IO.puts("#{file}: had an error! 😱")
      :error
  end
end)
|> Enum.group_by(fn status -> status end)
|> Enum.map(fn {status, problems} -> {status, Enum.count(problems)} end)
|> Enum.into(%{})
|> Map.put_new(:correct, 0)
|> Map.put_new(:incorrect, 0)
|> Map.put_new(:error, 0)
|> IO.inspect
|> case do
  %{incorrect: 0, error: 0} -> exit({:shutdown, 0})
  _other                    -> exit({:shutdown, 1})
end

defmodule WordleTerminalGame.Wordle do
  @moduledoc """
  Wordle Module can check how many exact matches, same position and letter,
  occurrences, same letter, or no matches are between a word (``answer``)
  and another word (``guess``). Uppercase and lowercase do not matter at all.

  - Exact matches => ``:green``
  - Matches/Occurrences => ``:yellow``
  - No matches => ``:gray``

  Prioritizing exact matches, and then, prioritizing first appearances.

  Both words have to contains same length and use only UTF-8 characters.
  """

  defp check_matches(guess, answer) do
    for {g, a} <- Enum.zip(guess, answer), do: if(g == a, do: :green, else: g)
  end

  defp check_occurrences(guess, answer) do
    occurrences = for {g, a} <- Enum.zip(guess, answer), !is_atom(g), do: a

    {_, result} =
      Enum.reduce(
        guess,
        {occurrences, []},
        fn guess_letter, {occurrences, result} ->
          cond do
            Enum.member?(occurrences, guess_letter) ->
              {occurrences -- [guess_letter], [:yellow | result]}

            true ->
              {occurrences, [guess_letter | result]}
          end
        end
      )

    result |> Enum.reverse()
  end

  defp no_matches(guess) do
    Enum.map(guess, fn x -> unless is_atom(x), do: :gray, else: x end)
  end

  @doc """
  Compare an answer (1st arg) with a guess (2nd arg).
  Returning a list where...
  - Exact matches are represented as ``[:green]``.
  - Occurrences are represented as ``[:yellow]`` (prioritizing first appearances).
  - No matches are represented as ``[:gray]``.

  Uppercase and lowercase do not matter at all.

  Return an ``error`` if answer and gray are not binary with same length.

  ## Examples
      iex> Wordle.feedback("foo", "oFf")
      [:yellow, :yellow, :gray ]

      iex> Wordle.feedback("green", "grnne")
      [:green, :green, :yellow, :gray, :yellow ]

      iex> Wordle.feedback("greed", "green")
      [:green, :green, :green, :green, :gray ]

      iex> Wordle.feedback("greed", 1)
      {:error, "Both arguments have to be strings."}

      iex> Wordle.feedback("greed", "aaaaaaaaaaaaaaaaaa")
      {:error, "Both arguments have to be strings with same length"}
  """

  @spec feedback(binary, binary) :: {:ok, list} | {:error, any}
  def feedback(answer, guess) when is_binary(answer) and is_binary(guess) do
    answer_list = answer |> String.downcase() |> String.to_charlist()
    guess_list = guess |> String.downcase() |> String.to_charlist()

    if String.length(answer) == String.length(guess) do
      result =
        guess_list
        |> check_matches(answer_list)
        |> check_occurrences(answer_list)
        |> no_matches()

      {:ok, result}
    else
      {:error, "Guess and answer must have the same number of letters."}
    end
  end

  def feedback(_answer, _guess) do
    {:error, "Both arguments have to be strings."}
  end
end

defmodule WordleTerminalGame do
  alias WordleTerminalGame.{Wordle, Words}

  @moduledoc """
  This module start the terminal game, use `iex[.bat] -S mix`
  to initialize the shell and then, inside shell run `WordleTerminalGame.start()`

  ```elixir
  > iex.bat -S mix #Windows
  > iex -S mix #Linux
  iex> WordleTerminalGame.start()
  ```
  """

  @spec colorize([integer], binary) :: binary
  defp colorize(result, guess) do
    Enum.join(
      Enum.map(
        Enum.zip(result, String.to_charlist(guess)),
        fn {x, y} ->
          case x do
            :green -> IO.ANSI.green() <> List.to_string([y]) <> IO.ANSI.reset()
            :yellow -> IO.ANSI.yellow() <> List.to_string([y]) <> IO.ANSI.reset()
            :gray -> IO.ANSI.black() <> List.to_string([y]) <> IO.ANSI.reset()
          end
        end
      )
    )
  end

  @doc """
    Giving a word as first argument (answer), something about the word as second argument (explanation)
    and a clue of the word as third argument (clue), ask you to try guess the answer giving you the clue.

    In case of:
     - **Right answer**: give you a comment about the answer and return to the start
     - **Wrong answer**:
       - ... with **correct format** input: give you a comment about the answer and return to the start
       - ... without **correct format** input: show you the error.
       - ... answering **exit**: end the game.
  """
  @spec play(binary, binary, binary) :: :ok
  def play(answer, explanation, clue) do
    guess =
      IO.gets(
        "Try to guess the word, contains #{String.length(answer)} letters and the clue is `#{clue}`: "
      )
      |> String.replace("\n", "", trim: true)
      |> String.downcase()

    unless guess == "exit" do
      result = Wordle.feedback(answer, guess)

      case result do
        {:error, msg} ->
          IO.puts("Error: " <> msg)
          play(answer, explanation, clue)

        {:ok, result} ->
          colorized_result = colorize(result, guess)

          if Enum.all?(result, fn x -> x == :green end) do
            colorized_result = colorize(result, guess)
            IO.puts("Right! The answer is #{colorized_result}")
            IO.puts("Do you know that ... #{explanation}")
            start()
          else
            IO.puts("Try again, the answer isn't #{colorized_result}")
            play(answer, explanation, clue)
          end
      end
    else
      IO.puts("Bye!")
    end
  end

  @doc """
  Explain the game and if run taking into account your answer.
  - If you answer anything that start with `y` (without caring the case), it's going to
    choose a random word sets in `WordleTerminalGame.Words` and starts the game.
  - End the game, if you answer anything that start with `n` (without caring the case).
  - Otherwise, ask you if you want to play.
  """
  def start() do
    start_playing =
      IO.gets("Hey, do you want to play Wordle? (Y/N)")
      |> String.downcase()
      |> String.trim()
      |> String.at(0)

    case start_playing do
      "y" ->
        IO.puts("Cool! You have to guess a word.")
        IO.puts("Rules:")

        IO.puts(
          "- If you find a letter and its position, the result is going to be in " <>
            IO.ANSI.green() <> ":green" <> IO.ANSI.reset()
        )

        IO.puts(
          "- If you find a letter, but not its position, the result is going to be in " <>
          IO.ANSI.yellow() <> ":yellow" <> IO.ANSI.reset()
        )

        IO.puts("- If you don't find a letter, the result is going to be in " <>
        IO.ANSI.black() <> ":gray" <> IO.ANSI.reset())

        IO.puts("All words are related to Elixir :)")
        IO.puts("You can exit when you want answering `exit`.")

        {result, explanation, clue} = Words.get() |> Enum.random()
        play(result, explanation, clue)

      "n" ->
        IO.puts("Okidoki! Bye ;(")

      _ ->
        IO.puts("Sorry :/ I don't understand you.")
        start()
    end
  end
end

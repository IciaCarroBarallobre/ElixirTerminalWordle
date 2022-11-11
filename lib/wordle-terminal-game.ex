defmodule WordleTerminalGame do
  alias WordleTerminalGame.{Wordle, Words}

  @moduledoc """
  This module contains a function ('start/0') to play Wordle with words
  related to Elixir in the iex shell interactive WordleTerminalGame.

  To initialize it:

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

  defp guess_the_answer(answer, explanation) do
    colorized_answer = IO.ANSI.green() <> answer <> IO.ANSI.reset()
    IO.puts("Right!! The answer is #{colorized_answer}.")
    :timer.sleep(1000)
    IO.puts("Did you know that ... #{explanation} \n")
    :timer.sleep(1000)
  end

  @doc """
    play/3 function asks you to try to guess the answer giving you a clue.
    - It's first argument is the answer.
    - It's second argument is an explanation related to the word (answer).
    - It's third argument is a clue about the answer.

    In case of:
     - **Right answer**: The function prints the answer and the explanation and return you to the start/0 function.
     - **Wrong answer**:
       - ... with **correct format** input: The function gives you clues about the answer and returns to itself (play/3).
       - ... without **correct format** input: The function shows you the error.
       - ... answering **exit**: end the game.
  """
  @spec play(binary, binary, binary, pid) :: :ok
  def play(answer, explanation, clue, pid) do
    guess =
      IO.gets("Contains #{String.length(answer)} letters, and a clue is `#{clue}`: ")
      |> String.replace("\n", "", trim: true)
      |> String.downcase()

    unless guess == "exit" do
      response = Wordle.feedback(answer, guess)

      case response do
        {:error, msg} ->
          IO.puts("Error: " <> msg)
          play(answer, explanation, clue, pid)

        {:ok, result} ->
          colorized_result = colorize(result, guess)

          if Enum.all?(result, fn x -> x == :green end) do
            guess_the_answer(guess, explanation)
            start(pid)
          else
            IO.puts("#{colorized_result}")
            play(answer, explanation, clue, pid)
          end
      end
    end
  end

  def explain_rules() do
    rules =
      "The game is about guessing a word related to Elixir. \n" <>
        "=> Find a letter of the answer in its position, it will be shown in " <>
        IO.ANSI.green() <>
        "green. \n" <>
        IO.ANSI.reset() <>
        "=> Find a letter of the answer but not in its position, it will be shown in " <>
        IO.ANSI.yellow() <>
        "yellow. \n" <>
        IO.ANSI.reset() <>
        "=> Don't guess the letter, it's going to be shown in " <>
        IO.ANSI.black() <>
        "grey. \n" <>
        IO.ANSI.reset() <>
        "You can exit when you want by answering 'exit'.\n"

    IO.puts(rules)
  end

  @doc """
  Start/0 function initialize the game and depending on your response:
  - Answering something that starts with 'y' or 'Y',
     - Explain how to play, the rules.
     - Choose a random word sets in `WordleTerminalGame.Words` and starts the game.
  - Answering anything that starts with 'n' or 'N', it ends the game.
  - Answering other things, return you to the same function but with helpful information.
  """
  def start() do
    {:ok, pid} = Words.start_link([])
    start(pid)
  end

  def start(pid) do
    IO.puts("-------------------------------------")
    IO.puts("----- ELIXIR SHELL WORDLE GAME ------")
    IO.puts("-------------------------------------")

    start_playing =
      IO.gets("Hey, do you want to play Wordle? (Y/N)")
      |> String.downcase()
      |> String.trim()
      |> String.at(0)

    case start_playing do
      "n" ->
        :ok

      "y" ->
        result = Words.pop(pid)

        unless result == nil do
          explain_rules()
          {answer, answer_explanation, clue} = result
          play(answer, answer_explanation, clue, pid)
        else
          IO.puts("I haven't got more guessing words! :(")
        end

      _ ->
        IO.puts("I don't understand you, type yes or no.")
        start(pid)
    end
  end
end

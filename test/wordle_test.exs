defmodule WordleTerminalGame.WordleTest do
  use ExUnit.Case
  alias WordleTerminalGame.Wordle, as: Wordle

  ############### Testing one color #########################
  test "feedback/2, guess the answer return all green" do
    word = "Apple"
    guess = "aPPLe"
    {:ok, result} = Wordle.feedback(word, guess)
    assert result == [:green, :green, :green, :green, :green]
  end

  test "feedback/2, no match any letter return all gray" do
    word = "apple"
    guess = "uooou"
    {:ok, result} = Wordle.feedback(word, guess)
    assert result == [:gray, :gray, :gray, :gray, :gray]
  end

  test "feedback/2, all letters in guess are disorder, return all yellow" do
    word = "apple"
    guess = "pAlep"
    {:ok, result} = Wordle.feedback(word, guess)
    assert result == [:yellow, :yellow, :yellow, :yellow, :yellow]
  end

  ################## Mix of colors #########################
  test "feedback/2, match some letters in the right position and no-match the rest" do
    word = "apple"
    guess = "axxle"
    {:ok, result} = Wordle.feedback(word, guess)
    assert result == [:green, :gray, :gray, :green, :green]
  end

  ################## Yellow edge cases: frequencies ##################
  test "feedback/2 prioritize exact matches of a letter" do
    word = "atcc"
    guess = "cacc"
    {:ok, result} = Wordle.feedback(word, guess)
    assert result == [:gray, :yellow, :green, :green]
  end

  test "feedback/2 prioritize exact matches of a letter, and then prioritize its firsts appearances, taking into account the frequencies of its" do
    word = "cacotta"
    guess = "pattata"
    {:ok, result} = Wordle.feedback(word, guess)
    assert result == [:gray, :green, :yellow, :gray, :gray, :green, :green]
  end

  ################## Error cases #########################
  test "feedback/2 with different length return an :error" do
    word = "a"
    guess = "aaaaa"
    {response, _result} = Wordle.feedback(word, guess)
    assert response == :error
  end

  test "feedback/2 when data type is no strings return an :error" do
    word = "a"
    guess = "aaaaa"
    {response, _result} = Wordle.feedback(word, guess)
    assert response == :error
  end
end

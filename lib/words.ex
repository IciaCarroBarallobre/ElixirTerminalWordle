defmodule WordleTerminalGame.Words do
  @moduledoc """
  Module that contains functions to create/0 a pre-define MapSet of Words,
  where the order does not matter, with a pop/1 functionality, to get its elements.

  A word is a tuple composed of {answer, explanation, clue}.
  """
  @type words :: {binary, binary, binary}

  @doc """
  create/0 returns a MapSet of Words.
  A Word is a tuple composed of {answer, explanation, clue}.
  """
  @spec create :: MapSet.t(words())
  def create() do
    MapSet.new([
      {
        "elixir",
        "Elixir is a dynamic, functional language for building scalable and maintainable applications.
    It runs on the Erlang VM, known for creating low-latency, distributed, and fault-tolerant systems.",
        "It's a language."
      },
      {"erlang",
       "Erlang is a programming language used to build massively scalable soft real-time systems with requirements
        on high availability. It runs on the Erlang VM, same as Elixir.", "It's a language."},
      {"strings", "Strings in Elixir are UTF-8 encoded binaries.", "Data type."},
      {"floats",
       " Floats (floating points) are not useful for representing money because cannot be stored exactly as it is in the memory.
        You could use instead Integers.", "Data Type"},
      {"enum",
       "Enum module provides a set of algorithms to work with enumerables (such as lists, maps and ranges).",
       "A Module"},
      {"livebook",
       "Livebook is an app to write interactive & collaborative code notebooks in Elixir.",
       "You can create notebooks with it."},
      {"mix",
       "Mix is a build tool that ships with Elixir that provides tasks for creating, compiling,
       testing your application, managing its dependencies and much more.", "Build tool."},
      {"iex", "IEx is the Elixir interactive shell.", "A shell."},
      {"exunit", "ExUnit is a testing framework for Elixir. ", "A framework for testing."},
      {"exdoc",
       "`mix docs` uses ExDoc to generate a static web page from the project documentation.",
       "A framework for documentation."}
      # TODO: Add more words
    ])
  end

  @doc """
  The function pop/1, giving a MapSet, returns a tuple that contains
  a random element of the MapSet and the same MapSet without the element.

  ## Examples

  iex> WordleTerminalGame.Words.pop(MapSet.new([1]))
  {1, #MapSet<[]>}

  iex> WordleTerminalGame.Words.pop(MapSet.new([]))
  {nil, #MapSet<[]>}

  """
  @spec pop(MapSet.t(any())) :: {any(), MapSet.t(any())}
  def pop(words) do
    unless Enum.empty?(words) do
      chosen_word = Enum.random(words)
      new_words = MapSet.delete(words, chosen_word)
      {chosen_word, new_words}
    else
      {nil, words}
    end
  end
end

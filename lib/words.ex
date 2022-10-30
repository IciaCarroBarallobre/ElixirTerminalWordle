defmodule WordleTerminalGame.Words do
  @moduledoc """
  Words has a module attribute which is a list that contains tuples of three elements ``(answer, explanation, clue)``.
  - The first element of the tuple, is the Wordle answer.
  - The second element of the tuple, is a detail about the answer.
  - The third element of the tuple, is a clue about the answer.
  """
  @available_words [
    {"elixir",
     "Elixir is a dynamic, functional language for building scalable and maintainable applications.
      It runs on the Erlang VM, known for creating low-latency, distributed, and fault-tolerant systems.",
     "It's a language."},
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
  ]

  @doc """
  Returns a list of tuples, its first element is a word related with Elixir,
  its second element is a detail/comment about the word and,
  its third element is a clue to guess the word.
  """

  @spec get :: [{binary, binary, binary}]
  def get() do
    @available_words
  end
end

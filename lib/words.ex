defmodule WordleTerminalGame.Words do
  @moduledoc """
  This module contain the list of existing answer and a pin out about them.
  In a future maybe could be created using an external file.
  """
  @available_words [
    {"elixir",
     "Elixir is a dynamic, functional language for building scalable and maintainable applications.
      It runs on the Erlang VM, known for creating low-latency, distributed, and fault-tolerant systems",
     "A language"},
    {"erlang",
     "Erlang is a programming language used to build massively scalable soft real-time systems with requirements
      on high availability. It runs on the Erlang VM, same as Elixir.", "A language"},
    {"strings", "Strings under the hood, are binary.", "Data Type"},
    {"floats", " Be careful! Not useful for money representation cause ", "Data Type"},
    {"enum",
     "Enum that provides a set of algorithms to work with enumerables (such as lists, maps and ranges).",
     "A Module"},
    {"livebook", "An app to write interactive & collaborative code notebooks in Elixir.",
     "Notebooks"},
    {"mix",
     "It's a build tool that ships with Elixir that provides tasks for creating, compiling,
     testing your application, managing its dependencies and much more;",
     "Build tool"},
    {"iex", "Elixir's interactive shell", "Shell"},
    {"exunit", "Unit testing framework for Elixir. ", "Test Framework"},
    {"exdoc",
     "`mix docs` uses ExDoc to generate a static web page from the project documentation", "Docs Framework"}
    # Add more in you want, in a future we can load using a external file
  ]

  @doc """
  Return a list of tuple which first element is the word related with Elixir
  and the second is the detail or comment about the word.
  """

  @spec get :: [{binary, binary, binary}]
  def get() do
    @available_words
  end
end

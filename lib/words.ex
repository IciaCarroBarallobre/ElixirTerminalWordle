defmodule WordleTerminalGame.Words do
  use GenServer

  @moduledoc """
  Words is a GenServer Callback Module which contains a MapSet.
  Its functionality is return a random element and delete this element from the MapSet.

  In our case element is a tuple composed of {word, explanation, clue}.
  """
  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [])
  end

  @doc """
  Returns a
  """
  def pop(pid) do
    GenServer.call(pid, :pop)
  end

  # Server callbacks
  @impl true
  def handle_call(:pop, _from, state) do
    unless Enum.empty?(state) do
      chosen_word = Enum.random(state)
      new_state = MapSet.delete(state, chosen_word)
      {:reply, chosen_word, new_state}
    else
      {:reply, nil, state}
    end
  end

  @impl true
  def init(_opts) do
    available_words =
      MapSet.new([
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
      ])

    {:ok, available_words}
  end
end

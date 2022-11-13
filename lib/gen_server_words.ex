defmodule WordleTerminalGame.GenServerWords do
  use GenServer
  alias WordleTerminalGame.{Words}

  @moduledoc """
  GenServerWords is a GenServer API which contains as a state a MapSet of Words.

  A word is a tuple composed of {answer, explanation, clue}.

  Its functionality is to return a random word and deleting this word
  from state, the MapSet of Words.
  """
  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [])
  end

  @doc """
  Returns a word which is deleted from the state.
  In case of state was empty, returns nil.
  """
  def pop(pid) do
    GenServer.call(pid, :pop)
  end

  @doc false
  def get(pid) do
    GenServer.call(pid, :get)
  end

  # Server callbacks
  @impl true
  def handle_call(:pop, _from, state) do
    {chosen_word, new_state} = Words.pop(state)
    {:reply, chosen_word, new_state}
  end

  # Server callbacks
  @impl true
  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  @impl true
  @spec init(any) :: {:ok, MapSet.t({binary, binary, binary})}
  def init(_opts) do
    available_words = Words.create()
    {:ok, available_words}
  end
end

defmodule WordleTerminalGame.GenServerWordsTest do
  use ExUnit.Case, async: true
  alias WordleTerminalGame.GenServerWords, as: GenServerWords

  setup do
    {:ok, pid} = start_supervised(GenServerWords)
    %{words_pid: pid}
  end

  describe "start_link/1" do
    test "Always start with a predefine list", %{words_pid: pid} do
      assert not Enum.empty?(GenServerWords.get(pid))
    end
  end

  describe "pop/1" do
    test "Return and remove the element from the state", %{words_pid: pid} do

      element = GenServerWords.pop(pid)
      assert not Enum.member?(GenServerWords.get(pid), element)
    end

    test "Return nil if state is empty", %{words_pid: pid} do
      for _i <- GenServerWords.get(pid), do: GenServerWords.pop(pid)
      assert nil == GenServerWords.pop(pid)
    end
  end
end

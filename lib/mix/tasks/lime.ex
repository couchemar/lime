defmodule Mix.Tasks.Lime do

  use Mix.Task

  @doc """
  Prepare grammar
  """
  def run _ do
    :ok = :neotoma.file 'priv/grammar.peg', [output: 'src', module: :lime_grammar]
  end

end
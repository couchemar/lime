defmodule Lime.Vocabularies.SimpleParser do
  use SandCat.Core

  alias SandCat.Core

  defword :token, [], do: [:tokens, :"pop-stack"]
  defword! :number?, [{:number, _line, val}], do: [:drop, true]
  defword! :"token>number", [{:number, _line, val}], do: [:drop, val]

  defword :parse, [], do: [
      [], :token, :dup, :number?, [ :"token>number" ], :when
  ]

end
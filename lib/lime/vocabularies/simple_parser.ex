defmodule Lime.Vocabularies.SimpleParser do
  use SandCat.Core

  alias SandCat.Core

  defp is_number?({:number, _line, _val}), do: [:drop, true]
  defp is_number?(_), do: [:drop, false]

  defp is_word?({:word, _line, val}), do: [:drop, true]
  defp is_word?(_), do: [:drop, false]

  defword :token, [], do: [:tokens, :"pop-stack"]
  defword! :number?, [token], do: is_number? token
  defword! :"token>number", [{:number, _line, val}], do: [:drop, val]

  defword! :"word?", [token], do: is_word? token
  defword! :"token>word", [{:word, _line, val}], do: [:drop, val]

  defword :parse, [], do: [
      [], :token, :dup,
      :number?, [ :"token>number" ], [
        :dup, :"word?", [ :"token>word" ], :when
      ], :if,
  ]

end
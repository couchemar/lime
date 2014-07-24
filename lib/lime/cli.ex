defmodule Lime.CLI do

  require SandCat
  alias SandCat.Words
  alias Lime.Vocabularies.SimpleParser

  @vocabularies [Words.words, SimpleParser.words]

  @derive [Access]
  defstruct sand_context: SandCat.new([], @vocabularies), counter: 1

  def start, do: :user_drv.start([:"tty_sl -c -e", {Lime.CLI, :boot, []}])

  def boot, do: spawn(fn -> start_server() end)

  defp start_server, do: struct(__MODULE__) |> server_loop

  defp server_loop ctx do
    prompt(ctx)
    try do
      case Lime.IO.read do
        {:parse_error, description} ->
          IO.inspect description
          ctx
        q ->
          IO.inspect q
          new_context = SandCat.compound(
               ctx[:sand_context], [ q, :tokens, :stack,
                                     :tokens, :"init-stack",
                                     :parse,
                                     #:call
                                   ]
          )
          print_stack new_context
          ctx |> update_counter |> update_context(new_context)
      end
    catch
      :error, error ->
        IO.inspect error
        IO.inspect System.stacktrace
        ctx
    end |> server_loop
  end

  defp prompt(%__MODULE__{counter: counter}), do: IO.write "Lime(#{counter})> "

  defp update_counter %__MODULE__{counter: counter}=ctx do
    put_in(ctx[:counter], counter + 1)
  end

  defp update_context(ctx, new_context) do
    put_in(ctx[:sand_context], new_context)
  end

  @max_items 10
  defp print_stack  %SandCat{stack: stack} do
    {top, rest} = Enum.split stack, @max_items
    rest_length = length rest
    if  rest_length > 0, do: IO.puts "#{rest_length} more items"
    for item <- top |> Enum.reverse, do: IO.inspect item
  end

end
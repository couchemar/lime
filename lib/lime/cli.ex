defmodule Lime.CLI do

  require SandCat

  @derive [Access]
  defstruct stack: [], counter: 1

  def start do
    :user_drv.start([:"tty_sl -c -e", {Lime.CLI, :boot, []}])
  end

  def boot do
    spawn(fn -> start_server() end)
  end

  defp start_server do
    struct(__MODULE__) |> server_loop
  end

  defp server_loop ctx do
    prompt(ctx)
    q = Lime.IO.read
    new_stack = ctx[:stack] |> SandCat.compound(q) |> IO.inspect
    ctx |> update_counter |> update_stack(new_stack) |> server_loop
  end

  defp prompt %__MODULE__{counter: counter} do
    IO.write "Lime(#{counter})> "
  end

  defp update_counter %__MODULE__{counter: counter}=ctx do
    struct(ctx, counter: counter + 1)
  end

  defp update_stack(ctx, new_stack) do
    struct(ctx, stack: new_stack)
  end

end
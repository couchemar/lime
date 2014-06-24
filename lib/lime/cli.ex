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
    try do
      case Lime.IO.read do
        {:parse_error, description} ->
          IO.inspect description
          ctx
        q ->
          new_stack = SandCat.compound(
               ctx[:stack], q
          ) |> IO.inspect
          ctx |> update_counter |> update_stack(new_stack)
      end
    catch
      :error, error ->
        IO.inspect error
        IO.inspect System.stacktrace
        ctx
    end |> server_loop
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
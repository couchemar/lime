defmodule Lime.CLI do

  require SandCat

  def start do
    :user_drv.start([:"tty_sl -c -e", {Lime.CLI, :boot, []}])
  end

  def boot do
    spawn(fn -> start_server() end)
  end

  defp start_server do
     server_loop
  end

  def server_loop do
    IO.write "Lime()> "
    q = Lime.IO.read
    SandCat.run(q) |> IO.inspect
    server_loop
  end
end
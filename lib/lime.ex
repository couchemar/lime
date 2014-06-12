defmodule Lime do
  use Application

  def start(_type, _args) do
    Lime.Supervisor.start_link
  end
end

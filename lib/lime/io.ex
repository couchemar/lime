defmodule Lime.IO do
  alias Lime.Parser

  def read do
    scan()
  end

  def scan() do
    case IO.gets('') do
      :eof ->
        :eof
      {:error, reason} ->
        throw reason
      data ->
        case :lime_scan.string(data) do
          {:ok, scanned, _} ->
            scanned
        end
    end
  end

end
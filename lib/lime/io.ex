defmodule Lime.IO do
  def read do
    scan_and_parse([])
  end

  def scan_and_parse([]) do
    case IO.gets('') do
      :eof ->
        :eof
      data ->
        case :lime_scan.string(data) do
          {:ok, scanned, _} ->
            case :lime_parse.parse(scanned) do
              {:ok, parsed} ->
                parsed
            end
        end
      {:error, reason} ->
        throw reason
    end
  end

end
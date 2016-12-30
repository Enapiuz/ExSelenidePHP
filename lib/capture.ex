defmodule ExSelenidePHP.CaptureIO do
  @moduledoc ~S"""
  Copypasted from ExUnit.CaptureIO
  """
  def capture_io(fun) do
    do_capture_io(:standard_io, [], fun)
  end

  def capture_io(device, fun) when is_atom(device) do
    capture_io(device, [], fun)
  end

  def capture_io(input, fun) when is_binary(input) do
    capture_io(:standard_io, [input: input], fun)
  end

  def capture_io(options, fun) when is_list(options) do
    capture_io(:standard_io, options, fun)
  end

  def capture_io(device, input, fun) when is_binary(input) do
    capture_io(device, [input: input], fun)
  end

  def capture_io(device, options, fun) when is_list(options) do
    do_capture_io(map_dev(device), options, fun)
  end

  defp map_dev(:stdio),  do: :standard_io
  defp map_dev(:stderr), do: :standard_error
  defp map_dev(other),   do: other

  defp do_capture_io(:standard_io, options, fun) do
    prompt_config = Keyword.get(options, :capture_prompt, true)
    input = Keyword.get(options, :input, "")

    original_gl = Process.group_leader()
    {:ok, capture_gl} = StringIO.open(input, capture_prompt: prompt_config)
    try do
      Process.group_leader(self(), capture_gl)
      do_capture_io(capture_gl, fun)
    after
      Process.group_leader(self(), original_gl)
    end
  end

  defp do_capture_io(device, options, fun) do
    input = Keyword.get(options, :input, "")
    {:ok, string_io} = StringIO.open(input)
    case ExUnit.CaptureServer.device_capture_on(device, string_io) do
      {:ok, ref} ->
        try do
          do_capture_io(string_io, fun)
        after
          ExUnit.CaptureServer.device_capture_off(ref)
        end
      {:error, :no_device} ->
        _ = StringIO.close(string_io)
        raise "could not find IO device registered at #{inspect device}"
      {:error, :already_captured} ->
        _ = StringIO.close(string_io)
        raise "IO device registered at #{inspect device} is already captured"
    end
  end

  defp do_capture_io(string_io, fun) do
    try do
       _ = fun.()
      :ok
    catch
      kind, reason ->
        stack = System.stacktrace()
        _ = StringIO.close(string_io)
        :erlang.raise(kind, reason, stack)
    else
      :ok ->
        {:ok, output} = StringIO.close(string_io)
        elem(output, 1)
    end
  end
end

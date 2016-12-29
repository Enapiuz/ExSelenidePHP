defmodule ExSelenidePHP do
  def main(args \\ System.argv) do
    generators_dir = "generators"

    files = File.ls!(generators_dir)
    for file <- File.ls!(generators_dir),
      path = Path.join(generators_dir, file),
      File.regular?(path) do
        IO.puts "Starting file '#{path}'"
        Code.eval_file path
    end
  end
end

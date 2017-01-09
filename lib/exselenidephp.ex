import ExSelenidePHP.Processor

defmodule ExSelenidePHP do
  def main(_args \\ System.argv) do
    generators_dir = "generators"
    results_dir = "results"

    for file <- File.ls!(generators_dir),
        path = Path.join(generators_dir, file),
        File.regular?(path)
    do
      process_file(path, results_dir)
    end
    IO.puts "Done"
  end
end

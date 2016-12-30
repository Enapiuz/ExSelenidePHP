import ExSelenidePHP.CaptureIO

defmodule ExSelenidePHP do
  def main(args \\ System.argv) do
    generators_dir = "generators"
    results_dir = "results"

    files = File.ls!(generators_dir)
    for file <- File.ls!(generators_dir),
      path = Path.join(generators_dir, file),
      File.regular?(path) do
        execute_me = fn ->
          Code.eval_file path
        end

        captured = capture_io(execute_me)
        result_filename = "#{Path.basename(path, "exs")}php"
        File.write! Path.join(results_dir, result_filename), captured
    end
  end
end

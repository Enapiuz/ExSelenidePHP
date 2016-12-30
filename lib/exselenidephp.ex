import ExSelenidePHP.CaptureIO

defmodule ExSelenidePHP do
  def main(args \\ System.argv) do
    generators_dir = "generators"
    results_dir = "results"

    for file <- File.ls!(generators_dir),
      path = Path.join(generators_dir, file),
      File.regular?(path) do
        captured = capture_io fn ->
          IO.puts "<?php"
          IO.puts ""
          IO.puts "use Selenide\\By;"
          IO.puts "use Selenide\\Condition;"
          IO.puts "use QA\\Obj_User;"
          IO.puts ""
          IO.puts "class #{Path.basename(path, ".exs")} extends Testing_SeleniumTestCase"
          IO.puts "{"
          Code.eval_file path
          IO.puts "}"
        end

        result_filename = "#{Path.basename(path, "exs")}php"
        File.write! Path.join(results_dir, result_filename), captured
    end
  end
end

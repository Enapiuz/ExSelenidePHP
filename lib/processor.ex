import ExSelenidePHP.CaptureIO

defmodule ExSelenidePHP.Processor do
  def process_file(path, results_dir) do
    IO.puts "Start compiling test \"#{path}\"..."
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

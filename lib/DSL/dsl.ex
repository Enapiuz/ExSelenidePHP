defmodule ExSelenidePHP.DSL do
  defmacro open(url) do
    quote bind_quoted: [url: url] do
      IO.puts "        $this->selenide()->open('#{url}');"
    end
  end

  defmacro click(locatorType, locator) do
    quote bind_quoted: [locatorType: locatorType, locator: locator] do
      IO.puts "        $this->selenide()->find(By::#{locatorType}(\"#{locator}\"))->click();"
    end
  end

  defmacro test(name, do: action) do
    quote do
      IO.puts "<?php"
      IO.puts ""
      IO.puts "use Selenide\\By;"
      IO.puts "use Selenide\\Condition;"
      IO.puts ""
      IO.puts "class #{unquote(name)}Test extends Testing_SeleniumTestCase"
      IO.puts "{"
      IO.puts "    function test#{unquote(name)}"
      IO.puts "    {"
      unquote action
      IO.puts "    }"
      IO.puts "}"
    end
  end
end

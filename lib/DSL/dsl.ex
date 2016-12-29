defmodule ExSelenidePHP.DSL do
  require IEx

  def open(url) do
      "$this->selenide()->open('#{url}');"
  end

  defmacro test(name, do: action) do
      quote do
        IO.puts """
        <?php

        use Selenide\\By;
        use Selenide\\Condition;

        class #{unquote(name)}
        {
            function test#{unquote(name)}
            {
                #{unquote(action)}
            }
        }
        """
      end
  end
end

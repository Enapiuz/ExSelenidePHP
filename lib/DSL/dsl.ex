defmodule ExSelenidePHP.DSL do
  require IEx

  def open(url) do
      "Opening #{url}"
  end

  defmacro test(name, do: action) do
      quote do
        """
        <?php

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

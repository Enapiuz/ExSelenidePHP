defmodule ExSelenidePHP.DSL.Specific do
  defmacro prepare_user(internal_name) do
    quote bind_quoted: [internal_name: internal_name] do
      IO.puts "        $#{internal_name} = Obj_User::create();"
      IO.puts "        Testing_Cleanup::addUser($#{internal_name});"
      IO.puts "        $#{internal_name}->verifyEmail();"
    end
  end

  defmacro login(internal_name) do
    quote bind_quoted: [internal_name: internal_name] do
      IO.puts "        Testing_Web_User::loginWithoutRole($#{internal_name}->email, $#{internal_name}->password);"
    end
  end
end

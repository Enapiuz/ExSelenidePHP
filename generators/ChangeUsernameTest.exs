import ExSelenidePHP.DSL
import ExSelenidePHP.DSL.Specific

test "UsernameSaving" do
  prepare_user :new_user
  login :new_user
  open "/profile"
  click :xpath, "text()='Settings'"
  set :id, "username", "PewUser"
  click :text, "Save"
  assert_value :id, "username", "PewUser"
  assert_text :css, ".title", "Settings"
end

test "Something" do
  prepare_user :asdasd
end

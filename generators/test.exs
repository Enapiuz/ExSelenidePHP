import ExSelenidePHP.DSL

test "First" do
  # user = user.pro.get()
  # login user
  open "/profile"
  click :xpath, "text()='Настройки'"
  # set :id, "username", "Гедеонычище"
  click :text, "Сохранить"
end

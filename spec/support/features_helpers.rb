module FeaturesHelpers 
  def login(user)
    visit     login_path
    fill_in   "E-mail", with: user.email
    fill_in   "Senha",  with: user.password
    click_on  "Acessar"
  end

  def logout
    click_on "Sair"
  end
end

RSpec.configure do |config|
  config.include FeaturesHelpers
end

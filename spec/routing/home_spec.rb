require 'spec_helper'

describe "homepage" do
  it "root path should be home#index" do
    expect(get: root_path).to route_to(controller: "home", action: "index")
  end
end

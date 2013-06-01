require 'spec_helper'

describe Users do
  it "should get new" do
    get :new
    assert_response :success
  end

end

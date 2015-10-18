require 'spec_helper'

describe DojosHelper, type: :helper do
  describe "participate_button" do
    let(:dojo) { FactoryGirl.create(:dojo) }

    it "should display participate button when user is not logged" do
      correct_button = link_to("Eu vou!", participate_dojo_path(dojo), method: :put, class: "btn btn-success btn-block")
      result = participate_button(nil, dojo)
      expect(result).to eq(correct_button)
    end

    it "should display participate button when user is not a participant" do
      other = FactoryGirl.create(:user)
      correct_button = link_to("Eu vou!", participate_dojo_path(dojo), method: :put, class: "btn btn-success btn-block")
      result = participate_button(other, dojo)
      expect(result).to eq(correct_button)
    end

    it "should display quit button when user is a participant" do
      correct_button = link_to("Desistir :(", quit_dojo_path(dojo), method: :put, class: "btn btn-danger btn-block")
      result = participate_button(dojo.user, dojo)
      expect(result).to eq(correct_button)
    end
  end
end

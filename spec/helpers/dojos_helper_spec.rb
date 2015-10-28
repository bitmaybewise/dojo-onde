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

    describe "gravatar_url" do
      it 'should not rise error when user is nil' do
        expect { gravatar_url(nil) }.not_to raise_error
      end

      it 'should render a url to gravatar' do
        expect(gravatar_url(dojo.user)).to match(/^https:\/\/www\.gravatar\.com\/avatar\/[0-9a-z]{32}/)
      end
    end
  end
end

require 'spec_helper'

describe DojosHelper, type: :helper do
  describe "#participate_button" do
    let(:dojo) { FactoryGirl.create(:dojo) }

    it "displays participate button when user is not logged" do
      correct_button = link_to("Eu vou!", participate_dojo_path(dojo), method: :put, class: "btn btn-success btn-block")
      result = participate_button(nil, dojo)
      expect(result).to eq(correct_button)
    end

    it "displays participate button when user is not a participant" do
      other = FactoryGirl.create(:user)
      correct_button = link_to("Eu vou!", participate_dojo_path(dojo), method: :put, class: "btn btn-success btn-block")
      result = participate_button(other, dojo)
      expect(result).to eq(correct_button)
    end

    it "displays quit button when user is a participant" do
      correct_button = link_to("Desistir :(", quit_dojo_path(dojo), method: :put, class: "btn btn-danger btn-block")
      result = participate_button(dojo.user, dojo)
      expect(result).to eq(correct_button)
    end
  end

  describe "#gravatar_url" do
    context 'when user is not present' do
      it 'does not rise error' do
        expect { gravatar_url(nil) }.not_to raise_error
      end
    end

    context 'when user came from social auth and email is blank' do
      it 'renders the blank avatar url' do
        user = FactoryGirl.build(:user, email: nil)
        expect(gravatar_url(user)).to eq image_url("blank-avatar.jpg")
      end
    end

    context 'when user email present' do
      it 'renders a url to gravatar' do
        user = FactoryGirl.build(:user)
        expect(gravatar_url(user)).to match(/^https:\/\/www\.gravatar\.com\/avatar\/[0-9a-z]{32}/)
      end
    end
  end
end

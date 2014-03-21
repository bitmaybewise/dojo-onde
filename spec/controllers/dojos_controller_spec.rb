require 'spec_helper'

describe DojosController do
  let(:user) { FactoryGirl.create(:user) }
  let(:credentials) { { user_id: user.id } }
  let(:invalid_attributes) { { 'day' => '', 'local' => '', 'gmaps_link' => '' } }

  describe 'POST create' do
    context 'when invalid' do
      before do
        post :create, { dojo: invalid_attributes }, credentials
      end
      it { expect(assigns(:dojo)).to be_a_new Dojo }
      it { expect(assigns(:dojo).errors).to have(3).items }
      it { expect(response).to render_template :new }
    end
  end

  describe 'PUT update' do
    context 'when invalid' do
      let(:dojo) { FactoryGirl.create(:dojo) }
      before do
        put :update, { id: dojo, dojo: invalid_attributes }, credentials
      end
      it { expect(assigns(:dojo)).to eq dojo }
      it { expect(assigns(:dojo).errors).to have(3).items }
      it { expect(response).to render_template :edit }
    end
  end
end

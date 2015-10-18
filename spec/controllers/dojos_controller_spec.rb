require 'spec_helper'

describe DojosController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:credentials) { { user_id: user.id } }
  let(:invalid_attributes) { { 'day' => '', 'local' => '', 'gmaps_link' => '' } }

  describe 'POST create' do
    context 'when invalid' do
      it 'does not create' do
        post :create, { dojo: invalid_attributes }, credentials
        expect(assigns(:dojo)).to be_a_new Dojo
        expect(assigns(:dojo).errors.size).to eq 3
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT update' do
    context 'when invalid' do
      it 'does not update' do
        dojo = FactoryGirl.create(:dojo)
        put :update, { id: dojo, dojo: invalid_attributes }, credentials
        expect(assigns(:dojo)).to eq dojo
        expect(assigns(:dojo).errors.size).to eq 3
        expect(response).to render_template :edit
      end
    end
  end
end

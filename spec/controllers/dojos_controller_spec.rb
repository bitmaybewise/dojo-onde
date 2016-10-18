require 'spec_helper'

describe DojosController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:credentials) { { user_id: user.id } }
  let(:invalid_attributes) { { 'day' => '', 'local' => '', 'gmaps_link' => '' } }

  describe 'POST create' do
    context 'when invalid' do
      it 'does not create' do
        post :create, params: { dojo: invalid_attributes }, session: credentials
        expect(assigns(:dojo)).to be_a_new Dojo
        expect(assigns(:dojo).errors.size).to eq 3
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET edit' do
    context 'when not owner' do
      it 'does not edit' do
        dojo = FactoryGirl.create(:dojo)
        get :edit, params: { id: dojo }, session: credentials
        expect(response).to redirect_to dojo_path(dojo)
        expect(flash[:error]).to eq 'Somente o dono pode editar!'
      end
    end
  end

  describe 'PUT update' do
    context 'when invalid' do
      it 'does not update' do
        dojo = FactoryGirl.create(:dojo, user: user)
        put :update, params: { id: dojo, dojo: invalid_attributes }, session: credentials
        expect(assigns(:dojo)).to eq dojo
        expect(assigns(:dojo).errors.size).to eq 3
        expect(response).to render_template :edit
      end
    end

    context 'when not owner' do
      it 'does not update' do
        dojo = FactoryGirl.create(:dojo)
        put :update, params: { id: dojo, dojo: { local: 'Far Far Away' } }, session: credentials
        expect(response).to redirect_to dojo_path(dojo)
        expect(flash[:error]).to eq 'Somente o dono pode editar!'
      end
    end
  end

  describe 'DELETE destroy' do
    context 'when not owner' do
      it 'does not destroy' do
        dojo = FactoryGirl.create(:dojo)
        delete :destroy, params: { id: dojo }, session: credentials
        expect(response).to redirect_to dojo_path(dojo)
        expect(flash[:error]).to eq 'Somente o dono pode editar!'
      end
    end
  end
end

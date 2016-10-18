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

  describe 'GET edit' do
    context 'when not owner' do
      it 'does not edit' do
        dojo = FactoryGirl.create(:dojo)
        get :edit, { id: dojo }, credentials
        expect(response).to redirect_to dojo_path(dojo)
        expect(flash[:error]).to eq 'Somente o dono pode editar!'
      end
    end
  end

  describe 'PUT update' do
    context 'when invalid' do
      it 'does not update' do
        dojo = FactoryGirl.create(:dojo, user: user)
        put :update, { id: dojo, dojo: invalid_attributes }, credentials
        expect(assigns(:dojo)).to eq dojo
        expect(assigns(:dojo).errors.size).to eq 3
        expect(response).to render_template :edit
      end
    end

    context 'when not owner' do
      it 'does not update' do
        dojo = FactoryGirl.create(:dojo)
        put :update, { id: dojo, dojo: { local: 'Far Far Away' } }, credentials
        expect(response).to redirect_to dojo_path(dojo)
        expect(flash[:error]).to eq 'Somente o dono pode editar!'
      end
    end
  end

  describe 'DELETE destroy' do
    context 'when not owner' do
      it 'does not destroy' do
        dojo = FactoryGirl.create(:dojo)
        delete :destroy, { id: dojo }, credentials
        expect(response).to redirect_to dojo_path(dojo)
        expect(flash[:error]).to eq 'Somente o dono pode editar!'
      end
    end
  end
end

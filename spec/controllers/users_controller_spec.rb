require 'spec_helper'

describe UsersController, type: :controller do
  let(:invalid_attributes) { { 'name' => '', 
                               'email' => '', 
                               'password' => '', 
                               'password_confirmation' => '' } }

  describe 'POST create' do
    context 'when invalid' do
      it 'does not create' do
        post :create, user: invalid_attributes
        expect(assigns(:user)).to be_a_new User
        expect(assigns(:user).errors.size).to eq 4
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT update' do
    context 'when invalid' do
      it 'does not update' do
        user = FactoryGirl.create(:user)
        credentials = { user_id: user.id }

        put :update, { id: user, user: invalid_attributes }, credentials

        expect(assigns(:user)).to eq user
        expect(assigns(:user).errors.size).to eq 3
        expect(response).to render_template :edit
      end
    end
  end
end

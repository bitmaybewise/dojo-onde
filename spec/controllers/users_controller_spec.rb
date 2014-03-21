require 'spec_helper'

describe UsersController do
  let(:invalid_attributes) { { 'name' => '', 'email' => '', 
                               'password' => '', 'password_confirmation' => '' } }

  describe 'POST create' do
    context 'when invalid' do
      before do
        post :create, { user: invalid_attributes }
      end
      it { expect(assigns(:user)).to be_a_new User }
      it { expect(assigns(:user).errors).to have(4).items }
      it { expect(response).to render_template :new }
    end
  end

  describe 'PUT update' do
    let(:user) { FactoryGirl.create(:user) }
    let(:credentials) { { user_id: user.id } }

    context 'when invalid' do
      before do
        put :update, { id: user, user: invalid_attributes }, credentials
      end
      it { expect(assigns(:user)).to eq user }
      it { expect(assigns(:user).errors).to have(3).items }
      it { expect(response).to render_template :edit }
    end
  end
end

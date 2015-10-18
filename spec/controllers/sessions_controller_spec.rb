require 'spec_helper'

describe SessionsController, type: :controller do
  describe 'GET social' do
    before do
      request.env['omniauth.auth'] = { uid: 123, 
                                       provider: 'twitter', 
                                       info: { email: 'fulano@detal.com' } 
                                     }
    end

    context 'unauthenticated' do
      context 'when user not found' do
        it 'creates an authorization along with user and authenticate' do
          get :social, provider: 'twitter'

          user = User.last
          expect(response).to redirect_to edit_user_path(user)
          expect(User.count).to eq 1
          expect(Authentication.count).to eq 1
          expect(session[:user_id]).not_to be_blank
        end
      end

      context 'when user found' do
        it 'creates an authorization and authenticate' do
          user = FactoryGirl.create(:user, email: 'fulano@detal.com')

          get :social, provider: 'twitter'

          expect(response).to redirect_to edit_user_path(user)
          expect(User.count).to eq 1
          expect(Authentication.count).to eq 1
          expect(session[:user_id]).not_to be_blank
        end
      end
    end

    context 'authenticated' do
      let(:user) { FactoryGirl.create(:user) }
      let(:credentials) { { user_id: user.id } }

      it 'creates authorization when does not exist' do
        get :social, { provider: 'twitter' }, credentials

        expect(response).to redirect_to edit_user_path(user)
        expect(user.authentications.size).to eq 1 
      end

      it 'does not create authorization when exists' do
        user.authentications.create(uid: 123, provider: 'twitter')
        
        get :social, { provider: 'twitter' }, credentials

        expect(response).to redirect_to edit_user_path(user)
        expect(user.authentications.size).to eq 1 
      end
    end
  end
end

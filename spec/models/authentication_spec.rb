require 'spec_helper'

describe Authentication, type: :model do
  describe '.from_oauth!' do
    let(:user) { FactoryGirl.create(:user, name: 'Fulano') }

    context 'when user provided' do
      context 'and authentication does not exist' do
        it 'creates authentication and update user name' do
          oauth = OAuthData.new({ uid: 123, 
                                  provider: 'twitter', 
                                  info: { name: 'Cicrano', email: 'cicrano@detal.com' }
                                })

          user_from_oauth = Authentication.from_oauth!(oauth, user)

          expect(user_from_oauth).to eq user
          expect(user.name).to eq 'Cicrano'
          expect(Authentication.count).to eq 1
          auth = Authentication.last
          expect(auth.user_id).to eq user.id
          expect(auth.uid).to eq '123'
          expect(auth.provider).to eq 'twitter'
        end
      end

      context 'and authentication exists' do
        it 'updates user name and does not create a new authentication' do
          Authentication.create!(user: user, uid: 123, provider: 'twitter')
          oauth = OAuthData.new({ uid: 123, 
                                  provider: 'twitter', 
                                  info: { name: 'Cicrano', email: 'cicrano@detal.com' }
                                })

          user_from_oauth = Authentication.from_oauth!(oauth, user)

          expect(user_from_oauth).to eq user
          expect(user.name).to eq 'Cicrano'
          expect(Authentication.count).to eq 1
        end
      end
    end

    context 'when user found' do
      context 'and authentication does not exist' do
        it 'creates authentication and update user name' do
          oauth = OAuthData.new({ uid: 123, 
                                  provider: 'twitter', 
                                  info: { name: 'Cicrano', email: user.email }
                                })

          user_from_oauth = Authentication.from_oauth!(oauth)

          user.reload
          expect(user_from_oauth).to eq user
          expect(user.name).to eq 'Cicrano'
          expect(Authentication.count).to eq 1
          auth = Authentication.last
          expect(auth.user_id).to eq user.id
          expect(auth.uid).to eq '123'
          expect(auth.provider).to eq 'twitter'
        end
      end

      context 'and authentication exists' do
        it 'updates user name and does not create authentication' do
          Authentication.create!(user: user, uid: 123, provider: 'twitter')
          oauth = OAuthData.new({ uid: 123, 
                                  provider: 'twitter', 
                                  info: { name: 'Cicrano', email: user.email }
                                })

          user_from_oauth = Authentication.from_oauth!(oauth, user)

          user.reload
          expect(user_from_oauth).to eq user
          expect(user.name).to eq 'Cicrano'
          expect(Authentication.count).to eq 1
        end
      end
    end

    context 'when user not found' do
      it 'creates user along with authentication' do
        oauth = OAuthData.new({ uid: 123, 
                                provider: 'twitter', 
                                info: { name: 'Cicrano', email: 'cicrano@detal.com' }
        })

        user_from_oauth = Authentication.from_oauth!(oauth)

        expect(user_from_oauth).to be_persisted
        expect(User.count).to eq 1
        expect(user_from_oauth.name).to eq 'Cicrano'
        expect(user_from_oauth.email).to eq 'cicrano@detal.com'
        expect(Authentication.count).to eq 1
        auth = Authentication.last
        expect(auth.user_id).to eq user_from_oauth.id
        expect(auth.uid).to eq '123'
        expect(auth.provider).to eq 'twitter'
      end
    end
  end
end

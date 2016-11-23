# frozen_string_literal: true
require 'rails_helper'

describe OmniauthCallbacksController, type: :controller do
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
    provider: 'github',
    uid: '123545',
    info: {
      email: 'bob@example.org',
      nickname: 'nickname',
      name: 'name',
      image: 'http://github.com/avatar.png'
    }
  )

  before(:each) do
    request.env["devise.mapping"] = Devise.mappings[:user]
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
  end

  context 'not logged in' do
    it 'creates the user' do
      expect { get :github }.to change(User, :count).by(1)
      expect(User.last).to be_confirmed
    end

    context 'when a user with the same email already exists' do
      fixtures :users
      it 'fails' do
        expect { get :github }.not_to change(User, :count)
        expect(response).to redirect_to(new_user_registration_path)
        expect(flash[:error]).to eq('A user with your GitHub email or nickname address already exists.')
      end
    end
  end

  context 'logged in' do
    fixtures :users
    login_user

    it 'updaes the using with the providers information' do
      expect { get :github }.not_to change(User, :count)
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq('Successfully connected to your GitHub account.')
    end
  end
end

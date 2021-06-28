require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users/new" do
    it '新規登録画面の表示に成功すること' do
      get '/users/new'
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /users/new" do
    it '新規登録に成功すること' do
      post users_path, params: { user: { email: "test@e.com", password: "1234"} }
      expect(response).to have_http_status(302)
    end
  end
end

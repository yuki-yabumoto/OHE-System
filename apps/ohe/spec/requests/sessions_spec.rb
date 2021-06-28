require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /login" do
    it 'ログイン画面の表示に成功すること' do
      get new_session_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /login" do
    context 'ユーザーが存在する場合' do
      it 'パスワードが正しくログインに成功すること' do
        post session_path, params: { login_form: { email: "test@a.com", password: "1234"} }
        expect(response).to have_http_status(200)
      end
      it 'パスワードが異なりログインに失敗すること' do
        post session_path, params: { login_form: { email: "test@a.com", password: "abcd"} }
        expect(response.body).to include 'パスワードまたはメールアドレスが違います'
      end
    end

    context 'ユーザーが存在しない場合' do
      it 'ログインに失敗すること' do
        post session_path, params: { login_form: { email: "test@b.com", password: "1234"} }
        expect(response.body).to include 'パスワードまたはメールアドレスが違います'
      end
    end
  end
end
require 'rails_helper'

describe 'ルーティング' do
  example 'OHEトップページ' do
    expect(get: "http://localhost").to route_to(controller: "top", action: "index")
  end

  example 'ログインページ' do
    expect(get: "http://localhost/login")
      .to route_to(controller: 'sessions', action: 'new')
  end

  example 'ユーザー新規登録画面' do
    expect(get: "http://localhost/users/new")
      .to route_to(controller: 'users', action: 'new')
  end

  example 'ユーザー情報入力画面' do
    expect(get: "http://localhost/users/edit")
      .to route_to(controller: 'users', action: 'edit')
  end

  example '服の追加画面' do
    expect(get: "http://localhost/clothes/new")
      .to route_to(controller: 'clothes', action: 'new')
  end
end

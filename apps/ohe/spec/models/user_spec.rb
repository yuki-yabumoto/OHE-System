##
## File Name      : users_spec.rb
## Version        : v1.0
## Designer       : 籔本悠紀
## Date           : 2021.06.26
## Purpose        : Userモデルのテスト
##

require 'rails_helper'

describe User do
  describe "天気予報の取得" do
    example "天気が得られるかどうか" do
      user = User.new(email: "test@example.com", place: "Tokyo", from_time: Time.now, to_time: Time.now + 1)
      weather = user.getWeatherForecast
      expect(weather).not_to eq nil
    end
  end
end
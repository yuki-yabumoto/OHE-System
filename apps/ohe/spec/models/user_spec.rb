##
## File Name      : users_spec.rb
## Version        : v1.1
## Designer       : 籔本悠紀
## Date           : 2021.07.03
## Purpose        : Userモデルのテスト
##

require 'rails_helper'

describe User do
  describe "天気予報の取得" do
    example "気温が得られるかどうか" do
      user = User.new(email: "test@example.com", place: "Tokyo", from_time: Time.now.to_date, to_time: Time.now.to_date + 3600)
      weather = user.getWeatherForecast
      expect(weather[:min_temperature]).not_to eq nil
    end

    example "気温が得られるかどうか" do
      user = User.new(email: "test@example.com", place: "Tokyo", from_time: Time.now.to_date, to_time: Time.now.to_date + 3600)
      weather = user.getWeatherForecast
      expect(weather[:max_humidity]).not_to eq nil
    end

    example "気温が得られるかどうか" do
      user = User.new(email: "test@example.com", place: "Tokyo", from_time: Time.now.to_date, to_time: Time.now.to_date + 3600)
      weather = user.getWeatherForecast
      expect(weather[:weather]).not_to eq nil
    end
  end
end
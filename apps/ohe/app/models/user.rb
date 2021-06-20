##
## File Name    : user.rb
## Version      : v2.0
## Designer     : 籔本悠紀, 中森楓太, 京増ほのか
## Date         : 2021.06.15
## Purpose      : Userモデルの定義
##

require "json"
require "open-uri"

class User < ApplicationRecord
  has_many :clothes, class_name: "Clothe", dependent: :destroy

  def hashed_password=(raw_password)
    if raw_password.kind_of?(String)
      self.password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.password = nil
    end
  end

  # ユーザが指定した都道府県と時間帯の天気，気温，湿度をハッシュにして返す
  def getWeatherForecast
    api_key = "db5db357d87b4994af16ed201cd5faaf"
    base_url = "http://api.openweathermap.org/data/2.5/forecast"
    place = "Tokyo" #ユーザ情報から入力

    #インデント無しの読みにくい形
    response = OpenURI.open_uri(base_url + "?q=#{:place},jp&APPID=#{api_key}")

    #JSON形式からrubyオブジェクトに変換してから読みやすい形のJSON形式に変換
    #puts JSON.pretty_generate(JSON.parse(response.read))

    forecasts = JSON.parse(JSON.pretty_generate(JSON.parse(response.read))) #hashに変換

    # from_timeとto_timeを3時間単位に丸める
    from_time = Time.at((:from_time.to_time.to_i / (3600 * 3)).round * (3600 * 3))
    to_time = Time.at((:to_time.to_time.to_i / (3600 * 3)).round * (3600 * 3))

    weather_icon_hash =
      { "01" => 0, "02" => 1, "03" => 2, "04" => 3,
        "09" => 4, "10" => 5, "11" => 6, "13" => 7, "50" => 8 }

    temperature_list = []
    humidity_list = []
    weather_list = []
    forecasts["list"].each do |forecast|
      if forecast["dt"] < from_time.to_i then next end
      if to_time.to_i < forecast["dt"] then break end

      weather_list.push(weather_icon_hash[hash["weather"][0]["icon"][0, 2]])
      temperature_list.push(hash["main"]["temp"].round - 273)
      humidity_list.push(hash["main"]["humidity"])
    end

    # 返り値(気温，湿度，天気を入れたハッシュ)
    { :min_temperature => temperature_list.min,
      :max_humidity => humidity_list.max,
      :weather => weather_list.max }
  end
end

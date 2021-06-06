##
##  File Name        : GetWeatherForcast
##  Version        : V1.0
##  Designer        : 京増 ほのか
##  Date        : 2021.06.06
##  Purpose           : 天気情報を返す(出力する)。
##

API_KEY = "db5db357d87b4994af16ed201cd5faaf"
BASE_URL = "http://api.openweathermap.org/data/2.5/forecast"
place = "Tokyo" #ユーザ情報から入力

require 'json'
require 'open-uri'

response = OpenURI.open_uri(BASE_URL + "?q=#{place},jp&APPID=#{API_KEY}") #インデント無しの読みにくい形

#JSON形式からrubyオブジェクトに変換してから読みやすい形のJSON形式に変換
#puts JSON.pretty_generate(JSON.parse(response.read))

hash = JSON.parse(JSON.pretty_generate(JSON.parse(response.read))) #hashに変換

#現在に近い時間の天気を取得
temp = (hash["list"][2]["main"]["temp"] - 273).round
weather = hash["list"][2]["weather"][0]["main"]
humidity = hash["list"][2]["main"]["humidity"]
time = hash["list"][2]["dt_txt"]

#test
#気温(temp),天気(weather),湿度(humidity)
puts("\r\n         　　  　       [ #{place} ]           ")
puts("    -------------- #{time} --------------")
puts("    temperature:#{temp}°C   weather:#{weather}   humidity:#{humidity}%")
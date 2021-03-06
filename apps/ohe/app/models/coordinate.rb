##
##  File Name        : coordinate.rb
##  Version        : V1.5
##  Designer        : 京増ほのか
##  Date        : 2021.07.07
##  Purpose           : コーディネート提案
##

class Coordinate < ApplicationRecord
    
    belongs_to :user, class_name: "User", foreign_key: "user_id", optional: true
    belongs_to :clothes, class_name: "Clothe", foreign_key: "tops", optional: true
    belongs_to :clothes, class_name: "Clothe", foreign_key: "bottoms", optional: true
    belongs_to :clothes, class_name: "Clothe", foreign_key: "outer", optional: true
    belongs_to :clothes, class_name: "Clothe", foreign_key: "shoes", optional: true
    belongs_to :clothes, class_name: "Clothe", foreign_key: "accessory", optional: true

    private def voting(i, j, k, l, m, coordination_option, tops, bottoms, outer, shoes, accessory, favorite_color, favorite_type)

        #コーディネート候補
        coordination_option[i+j+k+l+m] = {}
        coordination_option[i+j+k+l+m][:votes] = 0
        coordination_option[i+j+k+l+m][:bottoms] = bottoms[i]
        coordination_option[i+j+k+l+m][:shoes] = shoes[j]
        coordination_option[i+j+k+l+m][:tops] = tops[l]

        #アウターの選択と投票
        if outer.count != 0 then
            coordination_option[i+j+k+l+m][:outer] = outer[m]
            if outer[m].color == favorite_color then coordination_option[i+j+k+l+m][:votes] += 1
            else coordination_option[i+j+k+l+m][:votes] -= 2 end
            if outer[m].type == favorite_type then coordination_option[i+j+k+l+m][:votes] += 2
            else coordination_option[i+j+k+l+m][:votes] -= 2 end
        end

        #アクセサリーの選択と投票
        if accessory.count != 0 then
            coordination_option[i+j+k+l+m][:accessory] = accessory[k]
            if accessory[k].color == favorite_color then coordination_option[i+j+k+l+m][:votes] += 1
            else coordination_option[i+j+k+l+m][:votes] -= 2 end
            if accessory[k].type == favorite_type then coordination_option[i+j+k+l+m][:votes] += 2
            else coordination_option[i+j+k+l+m][:votes] -= 2 end
        end

        #コーディネートの色による投票
        if bottoms[i].color == favorite_color then coordination_option[i+j+k+l+m][:votes] += 1
        else coordination_option[i+j+k+l+m][:votes] -= 2 end
        if shoes[j].color == favorite_color then coordination_option[i+j+k+l+m][:votes] += 1
        else coordination_option[i+j+k+l+m][:votes] -= 2 end
        if tops[l].color == favorite_color then
            if outer.count == nil then coordination_option[i+j+k+l+m][:votes] += 2
            else coordination_option[i+j+k+l+m][:votes] += 1 end
        else coordination_option[i+j+k+l+m][:votes] -= 2 end
        
        #コーディネートのタイプによる投票
        if bottoms[i].type == favorite_type then coordination_option[i+j+k+l+m][:votes] += 2
        else coordination_option[i+j+k+l+m][:votes] -= 2 end
        if shoes[j].type == favorite_type then coordination_option[i+j+k+l+m][:votes] += 2
        else coordination_option[i+j+k+l+m][:votes] -= 2 end
        if tops[l].type == favorite_type then
            if outer.count == 0 then coordination_option[i+j+k+l+m][:votes] += 4
            else coordination_option[i+j+k+l+m][:votes] += 2 end
        else coordination_option[i+j+k+l+m][:votes] -= 2 end
        
        #再帰呼び出しによる繰り返し処理
        if m < (outer.count-1) then voting(i, j, k, l, m+1, coordination_option, tops, bottoms, outer, shoes, accessory, favorite_color, favorite_type)
        elsif l < (tops.count-1) then voting(i, j, k, l+1, 0, coordination_option, tops, bottoms, outer, shoes, accessory, favorite_color, favorite_type)
        elsif k < (accessory.count-1) then voting(i, j, k+1, 0, 0, coordination_option, tops, bottoms, outer, shoes, accessory, favorite_color, favorite_type)
        elsif j < (shoes.count-1) then voting(i, j+1, 0, 0, 0, coordination_option, tops, bottoms, outer, shoes, accessory, favorite_color, favorite_type)
        elsif i < (bottoms.count-1) then voting(i+1, 0, 0, 0, 0, coordination_option, tops, bottoms, outer, shoes, accessory, favorite_color, favorite_type)
        else return 0 end
    end
    
    def suggest(temperature, humidity, weather, id)

        #C7から気温(temperature)と湿度(humidity)を受け取り不快指数(discomfort_index)を計算
        if temperature == nil or humidity == nil or weather == nil or id == nil then    
            e2 = '天気情報が取得できませんでした。'
            return e2
        end
        discomfort_index = 0.81 * temperature + 0.01 * humidity * (0.99 * temperature - 14.3) + 46.3
        
        #コーディネート候補の空の配列
        coordination_option = []
        
        #ユーザ情報のuser_idから好みの色1、色2、好みのスタイルを受け取る
        user_info = (User.find_by(id: id))
        favorite_color = user_info.favorite_color
        favorite_type = user_info.favorite_type

        #気温、不快指数、天気による条件分岐
        #トップスとアウターの選択
        if discomfort_index < 60 then #トップス(長袖)、アウター(厚手)
            tops = Clothe.where(user_id: id, kind: 1)
            outer = Clothe.where(user_id: id, kind: 3)
        elsif discomfort_index < 65 then
            if weather == 3 or weather == 2 then #トップス(長袖)、アウター(厚手)
                tops = Clothe.where(user_id: id, kind: 1)
                outer = Clothe.where(user_id: id, kind: 3)
            else #トップス(長袖)、アウター(薄手)
                tops = Clothe.where(user_id: id, kind: 1)
                outer = Clothe.where(user_id: id, kind: 2)
            end
        elsif discomfort_index < 70 then
            if temperature >= 25 then #トップス(長袖)
                tops = Clothe.where(user_id: id, kind: 1)
                outer = []
            elsif weather == 0 then #トップス(長袖)
                tops = Clothe.where(user_id: id, kind: 1)
                outer = []
            else #トップス(長袖)、アウター(薄手)
                tops = Clothe.where(user_id: id, kind: 1)
                outer = Clothe.where(user_id: id, kind: 2)
            end
        elsif discomfort_index < 75 then
            if temperature >= 25 then #トップス(半袖)
                tops = Clothe.where(user_id: id, kind: 0)
                outer = []
            elsif weather == 2 then #トップス(長袖)
                tops = Clothe.where(user_id: id, kind: 1)
                outer = []
            else #トップス(長袖)、アウター(薄手)
                tops = Clothe.where(user_id: id, kind: 1)
                outer = Clothe.where(user_id: id, kind: 2)
            end
        else #トップス(半袖)
            tops = Clothe.where(user_id: id, kind: 0)
            outer = []
        end

        #ボトムス、シューズ、アクセサリーを全ての中から選ぶ
        bottoms = Clothe.where(user_id: id, kind: 5)
        shoes = Clothe.where(user_id: id, kind: 4)
        accessory = Clothe.where(user_id: id, kind: 6)
        
        if tops.count == 0 or bottoms.count == 0 or shoes.count == 0 then
            e1 = '服の登録が十分にできていません。服を登録してください。'
            return e1
        end
        
        #コーディネート候補の作成と投票
        voting(0, 0, 0, 0, 0, coordination_option, tops, bottoms, outer, shoes, accessory, favorite_color, favorite_type)

        #投票数の多い順にソート
        pp (coordination_option.sort do |a, b|
            b[:votes] <=> a[:votes]
          end)

        #投票数が最大の候補からコーディネートを選ぶ
        temp = []
        votes_max = coordination_option[0][:votes]
        for i in 0...coordination_option.length
           if coordination_option[i][:votes] == votes_max then temp << coordination_option[i] end
        end
        coordination_final = temp[0]
        if coordination_final == nil then
            e1 = '服の登録が十分にできていません。服を登録してください。'
            return e1
        else
            #最終的なコーディネート
            return coordination_final
        end
    end
end
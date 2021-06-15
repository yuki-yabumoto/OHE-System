##
##  File Name        : suggest_coordination_controller.rb
##  Version        : V1.0
##  Designer        : 京増ほのか
##  Date        : 2021.06.14
##  Purpose           : rubyファイル
##

class SuggestCoordinationController < ApplicationController
    def suggest
        #test
        temperature = 20
        humidity = 30
        weather = 0
        id = 1

        if temperature == nil or humidity == nil or weather == nil or id == nil then    
            @e2 = '天気情報が取得できませんでした。'
            return 0
        end

        #C7から気温(temperature)と湿度(humidity)を受け取り不快指数(discomfort_index)を計算
        @discomfort_index = 0.81 * temperature + 0.01 * humidity * (0.99 * temperature - 14.3) + 46.3
        
        #構造体クラス(コーディネート)、メンバ(トップス,アウター,ボトムス,シューズ,アクセサリー,投票数)
        coordination = Struct.new("Coordination", :tops,:outer, :bottoms, :shoes, :accesary, :votes)
        #コーディネート候補の空の配列
        @coordination_option = []
        #最終的に出力するコーディネート
        @coodination_final = coordination.new()
    
        #ユーザ情報のuser_idから好みの色1、色2、好みのスタイルを受け取る
        user_info = (UserInfo.find_by(user_id: id))
        color_combination1 = user_info.color_combination1
        color_combination2 = user_info.color_combination2
        style = user_info.style

        #気温、不快指数による条件分岐
        #トップスとアウターの選択
        if @discomfort_index < 60 then
            #トップス(長袖)、アウター(厚手)
            tops = ClothesInfo.where(user_id: id, clothes_type: 'LongSleevesTops')
            outer = ClothesInfo.where(user_id: id, clothes_type: 'ThickOuter')
        elsif @discomfort_index < 65 then
            if weather == 'Snow' or weather = 'Rain' then
                #トップス(長袖)、アウター(厚手)
                tops = ClothesInfo.where(user_id: id, clothes_type: 'LongSleevesTops')
                outer = ClothesInfo.where(user_id: id, clothes_type: 'ThickOuter')
            else
                #トップス(長袖)、アウター(薄手)
                tops = ClothesInfo.where(user_id: id, clothes_type: 'LongSleevesTops')
                outer = ClothesInfo.where(user_id: id, clothes_type: 'ThinOuter')
            end
        elsif @discomfort_index < 70 then
            if temperature >= 25 then
                #トップス(長袖)
                tops = ClothesInfo.where(user_id: id, clothes_type: 'LongSleevesTops')
                outer = ClothesInfo.where(user_id: id, clothes_type: 'NoOuter')
            elsif weather == 0 then
                #トップス(長袖)
                tops = ClothesInfo.where(user_id: id, clothes_type: 'LongSleevesTops')
                outer = ClothesInfo.where(user_id: id, clothes_type: 'NoOuter')
            else
                #トップス(長袖)、アウター(薄手)
                tops = ClothesInfo.where(user_id: id, clothes_type: 'LongSleevesTops')
                outer = ClothesInfo.where(user_id: id, clothes_type: 'ThinOuter')
            end
        elsif @discomfort_index < 75 then
            if temperature >= 25 then
                #トップス(半袖)
                tops = ClothesInfo.where(user_id: id, clothes_type: 'ShortSleevesTops')
                outer = ClothesInfo.where(user_id: id, clothes_type: 'NoOuter')
            elsif weather == 2 then
                #トップス(長袖)
                tops = ClothesInfo.where(user_id: id, clothes_type: 'LongSleevesTops')
                outer = ClothesInfo.where(user_id: id, clothes_type: 'NoOuter')
            else
                #トップス(長袖)、アウター(薄手)
                tops = ClothesInfo.where(user_id: id, clothes_type: 'LongSleevesTops')
                outer = ClothesInfo.where(user_id: id, clothes_type: 'ThinOuter')
            end
        else
            #トップス(半袖)
            tops = ClothesInfo.where(user_id: id, clothes_type: 'ShortSleevesTops')
            outer = ClothesInfo.where(user_id: id, clothes_type: 'NoOuter')
        end

        #ボトムス、シューズ、アクセサリーを全ての中から選ぶ
        bottoms = ClothesInfo.where(user_id: id, clothes_type: 'Bottoms')
        shoes = ClothesInfo.where(user_id: id, clothes_type: 'Shoes')
        accesary = ClothesInfo.where(user_id: id, clothes_type: 'Accesary')
        
        #コーディネート候補の作成と投票
        for i in 0...bottoms.count
            for j in 0...shoes.count
                for k in 0...accesary.count
                    for l in 0...tops.count
                        for m in 0...outer.count
                            #コーディネートの作成
                            @coordination_option[i+j+k+l+m] = coordination.new()
                            @coordination_option[i+j+k+l+m].votes = 0
                            @coordination_option[i+j+k+l+m].bottoms = bottoms[i]
                            @coordination_option[i+j+k+l+m].shoes = shoes[j]
                            @coordination_option[i+j+k+l+m].accesary = accesary[k]
                            @coordination_option[i+j+k+l+m].tops = tops[l]
                            @coordination_option[i+j+k+l+m].outer = outer[m]
                            #コーディネートの色による投票
                            if bottoms[i].clothes_color == color_combination1 or bottoms[i].clothes_color == color_combination2 then
                                @coordination_option[i+j+k+l+m].votes += 1
                            else 
                                @coordination_option[i+j+k+l+m].votes -= 2
                            end
                            if shoes[j].clothes_color == color_combination1 or shoes[j].clothes_color == color_combination2 then
                                @coordination_option[i+j+k+l+m].votes += 1
                            else 
                                @coordination_option[i+j+k+l+m].votes -= 2
                            end
                            if accesary[k].clothes_color == color_combination1 or accesary[k].clothes_color == color_combination2 then
                                @coordination_option[i+j+k+l+m].votes += 1
                            else 
                                @coordination_option[i+j+k+l+m].votes -= 2
                            end
                            if tops[l].clothes_color == color_combination1 or tops[l].clothes_color == color_combination2 then
                                if outer[m].clothes_type == 'NoOuter' then
                                    @coordination_option[i+j+k+l+m].votes += 2
                                else
                                    @coordination_option[i+j+k+l+m].votes += 1
                                end
                            else 
                                @coordination_option[i+j+k+l+m].votes -= 2
                            end
                            if outer[m].clothes_color == color_combination1 or outer[m].clothes_color == color_combination2 then
                                @coordination_option[i+j+k+l+m].votes += 1
                            else 
                                @coordination_option[i+j+k+l+m].votes -= 2
                            end
                            #コーディネートのスタイル(ジャンル)による投票
                            if bottoms[i].clothes_gener == style then
                                @coordination_option[i+j+k+l+m].votes += 2
                            else 
                                @coordination_option[i+j+k+l+m].votes -= 2
                            end
                            if shoes[j].clothes_gener == style then
                                @coordination_option[i+j+k+l+m].votes += 2
                            else 
                                @coordination_option[i+j+k+l+m].votes -= 2
                            end
                            if accesary[k].clothes_gener == style then
                                @coordination_option[i+j+k+l+m].votes += 2
                            else 
                                @coordination_option[i+j+k+l+m].votes -= 2
                            end
                            if tops[l].clothes_gener == style then
                                if outer[m].clothes_type == 'NoOuter' then
                                    @coordination_option[i+j+k+l+m].votes += 4
                                else
                                    @coordination_option[i+j+k+l+m].votes += 2
                                end
                            else 
                                @coordination_option[i+j+k+l+m].votes -= 2
                            end
                            if outer[m].clothes_gener == style then
                                @coordination_option[i+j+k+l+m].votes += 2
                            else 
                                @coordination_option[i+j+k+l+m].votes -= 2
                            end
                        end
                    end
                end
            end
        end

        #投票数の多い順にソート
        pp (@coordination_option.sort do |a, b|
            b[:votes] <=> a[:votes]
          end)

        #投票数が最大の候補からコーディネートを選ぶ
        temp = []
        votes_max = @coordination_option[0].votes
        
        for i in 0...@coordination_option.length
           if @coordination_option[i].votes == votes_max then
               temp << @coordination_option[i]
           end
        end

        @coordination_final = temp[0]

        if @coodination_final == nil then
            @e1 = '服の登録が十分にできていません。服を登録してください。'
        else 
            @tops = @coordination_final.tops.clothes_type
            @tops_color = @coordination_final.tops.clothes_color
            @outer = @coordination_final.outer.clothes_type
            @outer_color = @coordination_final.outer.clothes_color
            @bottoms = @coordination_final.bottoms.clothes_type
            @bottoms_color = @coordination_final.bottoms.clothes_color
            @accesary = @coordination_final.accesary.clothes_type
            @accesary_color = @coordination_final.accesary.clothes_color
            @shoes = @coordination_final.shoes.clothes_type
            @shoes_color = @coordination_final.shoes.clothes_color
        end

    end

end


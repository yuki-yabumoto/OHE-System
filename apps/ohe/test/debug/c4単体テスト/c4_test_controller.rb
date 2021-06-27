class C4TestController < ApplicationController
    require 'suggest_coordination_controller.rb'
    
    def test
        t = SuggestCoordinationController.new()
        @t = t.suggest(20,20,0,1)
        #0: 天気情報が読み取れない場合
        #1: 服情報が読み取れない場合
        #2: 天気情報と服情報が読み取れた場合
        test_case = 0
        if test_case == 0 then #ok 戻り値は1
            #天気情報とuser_idをnilとして引数にする
            @t = t.suggest(nil,nil,nil,nil)
        elsif test_case == 1 then #ok　戻り値は2
            #服情報を登録していないユーザのuser_idを引数とする
            @t = t.suggest(20,20,0,2)
        elsif test_case == 2 then #ok　戻り値はコーディネート
            #天気情報と服情報を登録済みのユーザのuser_idを引数とする
            @t = t.suggest(40,20,0,3)
        end
        
    end
end

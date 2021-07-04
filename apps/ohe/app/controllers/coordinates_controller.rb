##
##  File Name       : coordinates_controller.rb
##  Version         : V1.1
##  Designer        : 中馬，籔本
##  Date            : 2021.07.03
##  Purpose         : コーディネートコントローラー
##

class CoordinatesController < Base
    
    def index
        user = current_user
        @coordinates = Coordinate.where(user_id: user.id)
        @date = Coordinate.select("created_at")
    end

    def new
    end

    def create
        # 天気予報を取得
        user = current_user
        user.from_time = DateTime.parse("#{params["from(1i)"]}-#{params["from(2i)"]}-#{params["from(3i)"]}T#{params["from(4i)"]}:#{params["from(5i)"]}")
        user.to_time = DateTime.parse("#{params["to(1i)"]}-#{params["to(2i)"]}-#{params["to(3i)"]}T#{params["to(4i)"]}:#{params["to(5i)"]}")
        user.save
        @weather = user.getWeatherForecast

        # コーディネートを取得
        @coordinate = Coordinate.new
        @coordinate = @coordinate.suggest(@weather[:min_temperature], @weather[:max_humidity] \
                                , @weather[:weather], user.id)
        if !@coordinate.kind_of?(String)
            # エラーが起きてないとき，コーディネートをDBに保存
            param = {}
            param['user_id'] = user.id
            param['tops'] = @coordinate.tops != nil ? @coordinate.tops.id : nil
            param['bottoms'] = @coordinate.bottoms != nil ?  @coordinate.bottoms.id : nil
            param['outer'] = @coordinate.outer != nil ? @coordinate.outer.id : nil
            param['shoes'] = @coordinate.shoes != nil ? @coordinate.shoes.id : nil
            param['accessory'] = @coordinate.accessory.id != nil ? @coordinate.accessory.id : nil
            c = Coordinate.new(param)
            c.save
        end
        render action: "show"
    end

    def show
        render action: "show"
    end
     
    def destroy
        coordinate = Coordinate.find(params[:id])
        coordinate.destroy!
        flash.notice = "服を削除しました"
        redirect_to :coordinates   
    end     
end

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
        render action: "index"
    end

    def new
        user = current_user
        @weather = user.getWeatherForecast

        @coordinate = Coordinate.new
        @coordinate = @coordinate.suggest(@weather[:min_temperature], @weather[:max_humidity] \
                                , @weather[:weather], user.id)
        if !@coordinate.kind_of?(String)
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

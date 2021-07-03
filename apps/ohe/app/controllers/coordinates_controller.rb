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
        @coordinate = Coordinate.new
        user = current_user
        weather = user.getWeatherForecast
        @coordinate = @coordinate.suggest(weather[:min_temperature], weather[:max_humidity] \
                                , weather[:weather], user.id)
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

class CoordinateController < ApplicationController
    def new
        @coordinates=Coordinate.new
    end

    def show
        user = User.find(params[:id])
        @coordinates = Coordinate.where(user_id: user.id) #user_idが入力されたidと同じだった場合、coordinateモデルからとってくる
    end
end

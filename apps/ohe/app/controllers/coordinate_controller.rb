class CoordinateController < Base
    
    def index
        user = current_user
        @coordinates = Coordinate.where(user_id: user.id)
        @date = Coordinate.select("created_at")
        render action: "index"
    end
     
    def destroy
        coordinate = Coordinate.find(params[:id])
        coordinate.destroy!
        flash.notice = "服を削除しました"
        redirect_to :coordinates   
    end     
end

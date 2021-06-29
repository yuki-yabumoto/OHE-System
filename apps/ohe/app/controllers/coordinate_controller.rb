
class CoordinateController < ApplicationController

    def show
        @coordinates.image = find(params[:id])
        send_data @coordinates.photo, type => 'image/jpeg', :disposition => 'inline'
    end

    def destroy
        coordinate = Coordinate.find(params[:id]) #coordinateのIDを1つ検索
        coordinate.destroy
    end
end
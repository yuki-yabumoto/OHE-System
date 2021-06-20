class CoordinateController < ApplicationController

    def show
        @coordinates.image = "#{@coordinates.id}.jpg"
        image = params[:image_file]
        File.binwrite("public/#{@coordinates.image}",image.read)
    end

end

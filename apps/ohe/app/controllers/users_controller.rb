class UsersController < Base
  def new
    @user = User.new
  end
end

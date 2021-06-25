##
## File Name    : sessions_controller.rb
## Version      : v1.1
## Designer     : 籔本悠紀,中森楓太
## Date         : 2021.06.19
## Purpose      : セッションのコントローラー
##

class SessionsController < Base
<<<<<<< HEAD
   def new
     if current_user
       redirect_to :index
     else
       @form = LoginForm.new
       render action: "new"
     end
   end
=======
  def new
    if current_user
      redirect_to :index
    else
      @form = LoginForm.new
      render action: "new"
    end
  end
>>>>>>> bc1019b350c50811677a53f477e373fbbb314b9c

  def create
    @form = LoginForm.new(params[:login_form])
    if @form.email.present?
      user =
        User.find_by("LOWER(email) = ?", @form.email.downcase)
    end
    # ユーザー認証
    if user && user.authenticate(@form.password)
      session[:user_id] = user.id
      redirect_to :index
    else
      render action: "new"
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to :index
  end
end

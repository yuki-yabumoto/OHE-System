class SessionsController < Base
  def new
    if current_user
      redirect_to :root
    else
      @form = LoginForm.new
      render action: "new"
    end
  end

  def create
    @form = LoginForm.new(params[:login_form])
    if @form.email.present?
      user =
        User.find_by("LOWER(email) = ?", @form.email.downcase)
    end
    if user
      session[:user_id] = user.id
      redirect_to :root
    else
      render action: "new"
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to :root
  end
end

class Clearance::UsersController < Clearance::BaseController
  if respond_to?(:before_action)
    before_action :redirect_signed_in_users, only: [:create, :new]
    skip_before_action :require_login, only: [:create, :new], raise: false
    skip_before_action :authorize, only: [:create, :new], raise: false
  else
    before_filter :redirect_signed_in_users, only: [:create, :new]
    skip_before_filter :require_login, only: [:create, :new], raise: false
    skip_before_filter :authorize, only: [:create, :new], raise: false
  end

  def new
    @user = user_from_params
    render template: "users/new"
  end

  def create
    @user = User.new(new_user_params)
    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      render template: "users/new"
    end
  end

  def testing
      render template: "users/index"
  end

  private

  def avoid_sign_in
    warn "[DEPRECATION] Clearance's `avoid_sign_in` before_filter is " +
      "deprecated. Use `redirect_signed_in_users` instead. " +
      "Be sure to update any instances of `skip_before_filter :avoid_sign_in`" +
      " or `skip_before_action :avoid_sign_in` as well"
    redirect_signed_in_users
  end

  def redirect_signed_in_users
    if signed_in?
      redirect_to Clearance.configuration.redirect_url
    end
  end

  def url_after_create
    Clearance.configuration.redirect_url
  end

  def new_user_params
    params.require(:user).permit(:name, :email, :password, :avatar, :remote_avatar_url)
  end

  def user_from_params
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    # rmb to add this after adding any new columns
    name = user_params.delete(:name)
    avatar = user_params.delete(:remote_avatar_url)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
      # rmb to add this after adding any new columns
      user.name = name
      user.avatar = avatar
    end
  end

  def user_params
    params[Clearance.configuration.user_parameter] || Hash.new
  end
end
# encoding: utf-8
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    auth = request.env['omniauth.auth']
    #@user = User.where(auth.slice('provider', 'uid')).first
    @user = User.where(provider: auth.provider, uid: auth.uid).first

    if @user.present?
      sign_in(@user, event: :authentication)
      redirect_to session.has_key?(:return_url) ? session.delete(:return_url) : root_path
    else
      @user = User.create_from_omniauth_facebook auth
      #sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
      sign_in(@user, event: :authentication)
      redirect_to session.has_key?(:return_url) ? session.delete(:return_url) : root_path
    end
  end

  def google_oauth2
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth_gmail(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', :kind => 'Google'
      sign_in_and_redirect @user, :event => :authentication
    else
      session['devise.google_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  # TODO: Need to refactor this method. Should be multiple method with single tasks
  def twitter
    auth = request.env['omniauth.auth']
    user = User.where(auth.slice('provider', 'uid')).first
    if user.present?
      sign_in(user, event: :authentication)
      redirect_to session.has_key?(:return_url) ? session.delete(:return_url) : root_path
    else
      name = auth['info']['name'].split(/ /)
      length = name.length
      if length > 1
        last_name = name.pop(1).join(' ')
        first_name = name.join(' ')
      else
        first_name = auth['info']['name']
        last_name = ''
      end
      sign_up_data = { provider: auth['provider'],
                       uid:  auth['uid'],
                       image: auth['info']['image'].sub('_normal', ''),
                       first_name: first_name,
                       last_name:  last_name,
                       email:  '',
                       gender:  ''
      }

      session[:sign_up_data] = sign_up_data
      redirect_to request.referer.present? ? request.referer : root_path
    end
  end

  def email_available?(email)
    user = User.find_by_email(email)
    !user.present?
  end
end

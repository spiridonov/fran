class AuthController < ApplicationController

  skip_before_filter :require_user

  layout 'sign_in'

  def fb_callback
    koala = Koala::Facebook::OAuth.new(
      '448225325365100', 'b8f0521ab17603db9e50fa51d9d3bdcf', fb_redirect_uri
    )
    fb_token = koala.get_access_token(params[:code])
    
    if fb_token.present?
      koala = Koala::Facebook::API.new(fb_token)      
      me = koala.get_object("me")
      
      user = User.where(fb_id: me["id"]).first
      if user.present?
        user.fb_token = fb_token
        user.save!
      else
        user = User.create!(
          fb_id: me["id"],
          name: me["name"],
          fb_token: fb_token,
          invited_by_id: session[:referral_id],
        )
      end

      UserSession.create(user, true)
    else

    end

    redirect_to root_path
  end

  def vk_callback
    query = {
      client_id: '5012990',
      client_secret: 'l4nroPyYnzXgY59doT6b',
      code: params[:code],
      redirect_uri: vk_redirect_uri
    }

    conn = Faraday.new(url: 'https://oauth.vk.com') do |faraday|
      faraday.adapter Faraday.default_adapter
    end

    response = conn.get("/access_token?#{query.to_query}")
    json = JSON.parse(response.body)

    if json.has_key?("access_token")
      vk_token = json["access_token"]
      vk_id = json["user_id"]

      user = User.where(vk_id: vk_id).first
      if user.present?
        user.vk_token = vk_token
        user.save!
      else
        vk_result = VK::Application.new(version: '5.35').
          vk_call('users.get', {user_ids: vk_id, fields: 'first_name,last_name'}).first

        user = User.create!(
          vk_id: vk_result['id'],
          name: "#{vk_result['first_name']} #{vk_result['last_name']}",
          vk_token: vk_token,
          invited_by_id: session[:referral_id],
        )
      end

      UserSession.create(user, true)
    else
      raise json["error_description"]
    end

    redirect_to root_path
  end

  def sign_in
    @vk_auth_url = vk_auth_url
    @fb_auth_url = fb_auth_url
  end

  def sign_out
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to root_path
  end

  private

  def fb_auth_url
    koala = Koala::Facebook::OAuth.new(
      '448225325365100', 'b8f0521ab17603db9e50fa51d9d3bdcf', fb_redirect_uri
    )
    koala.url_for_oauth_code
  end

  def vk_auth_url
    query = {
      client_id: '5012990', 
      redirect_uri: vk_redirect_uri,
      scope: 'friends,offline,wall', 
      display: 'page', 
      response_type: 'code', 
      v: '5.37', 
      state: 'cfsmr'
    }.to_query

    "https://oauth.vk.com/authorize?#{query}"
  end

  def redirect_host
    if Rails.env.development?
      'http://cf.lvh.me:3000'
    else
      'http://cfsmr.spiridonov.pro'
    end
  end

  def vk_redirect_uri
    "#{redirect_host}/vk_callback"
  end

  def fb_redirect_uri
    "#{redirect_host}/fb_callback"
  end

end

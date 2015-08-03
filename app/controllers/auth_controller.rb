class AuthController < ApplicationController

  skip_before_filter :require_user

  layout 'sign_in'

  def vk_callback
    query = {
      client_id: '5012990',
      client_secret: 'l4nroPyYnzXgY59doT6b',
      code: params[:code],
      redirect_uri: redirect_uri
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
          first_name: vk_result['first_name'],
          last_name: vk_result['last_name'],
          vk_token: vk_token,
        )
      end

      UserSession.create(user, true)
    else
      raise json["error_description"]
    end

    redirect_to root_path
  end

  def sign_in
    query = {
      client_id: '5012990', 
      redirect_uri: redirect_uri,
      scope: 'friends', 
      display: 'page', 
      response_type: 'code', 
      v: '5.35', 
      state: 'cfsmr'
    }.to_query

    @auth_url = "https://oauth.vk.com/authorize?#{query}"      
  end

  def sign_out
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to root_path
  end

  private

  def redirect_uri
    if Rails.env.development?
      'http://cf.lvh.me:3000/vk_callback'
    else
      'http://cfsmr.spiridonov.pro/vk_callback'
    end
  end

end

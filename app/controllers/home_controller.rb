class HomeController < ApplicationController

  layout 'home'

  skip_before_filter :require_user

  def index
    @vk_auth_url = vk_auth_url
    @fb_auth_url = fb_auth_url
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
      'http://crossfitsmr.ru'
    end
  end

  def vk_redirect_uri
    "#{redirect_host}/vk_callback"
  end

  def fb_redirect_uri
    "#{redirect_host}/fb_callback"
  end

end
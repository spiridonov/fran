class UserPhotosService

  def initialize(users)
    users = Array.wrap(users)
    @photos = {
      small: get_photos(users, :small),
      large: get_photos(users, :large)
    }
  end

  def for(user, size)
    @photos[size.to_sym][user]
  end

  private

  def get_photos(users, size)
    photos = {}
    
    users.each { |user| photos[user] = get_from_cache(user, size) }

    empty_vk_users = users.select { |user| user.vk_id.present? && photos[user].blank? }
    empty_fb_users = users.select { |user| user.fb_id.present? && photos[user].blank? }

    if empty_vk_users.present?
      vk_photos = get_from_vk(empty_vk_users, size)
      put_to_cache(vk_photos, size)
      photos.merge!(vk_photos)
    end

    if empty_fb_users.present?
      fb_photos = get_from_fb(empty_fb_users, size)
      put_to_cache(fb_photos, size)
      photos.merge!(fb_photos)
    end

    photos
  end

  def get_from_cache(user, size)
    redis.get(cache_key(user, size))
  end

  def put_to_cache(photos, size)
    redis.pipelined do
      photos.each do |user, photo|
        redis.setex(cache_key(user, size), 12.hours, photo)
      end
    end
  end

  def cache_key(user, size)
    "fran:user_photos:#{size}:#{user.id}"
  end

  def get_from_fb(users, size)
    users.reduce({}) do |memo, user|
      koala = Koala::Facebook::API.new(user.fb_token)
      memo[user] = koala.get_picture('me', type: size.to_s)
      memo
    end
  end

  def get_from_vk(users, size)
    sizes = {
      small: 'photo_50',
      large: 'photo_400_orig'
    }
    vk_ids = users.map(&:vk_id)
    api = VK::Application.new(version: '5.37')
    vk_result = Array.wrap(api.vk_call('users.get', {user_ids: vk_ids, fields: sizes[size]}))
    
    users.reduce({}) do |memo, user|
      memo[user] = vk_result.find{ |r| r['id'].to_s == user.vk_id }[sizes[size]]
      memo
    end
  end

  def redis
    @redis ||= Redis.new
  end

end

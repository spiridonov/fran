class ShareService

  def initialize(user)
    @user = user
    if @user.vk_id.present?
      @service = VkShareService.new(@user)
    else
      @service = FbShareService.new(@user)
    end
  end

  def shares_count
    @service.shares_count
  end

  def wall_posts
    @service.wall_posts
  end

  def clicks_count
    redis.get("fran:shares:clicks:#{@user.id}").to_i
  end

  def add_clicks
    redis.incr("fran:shares:clicks:#{@user.id}")
  end

  def invited_users_count
    User.where(invited_by_id: @user.id).count
  end

  private

  def redis
    @redis ||= Redis.new
  end

end

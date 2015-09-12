class FbShareService

  def initialize(user)
    @user = user
  end

  def link_for_sharing
    # @link ||= "http://spiridonov.pro/?ref=#{@user.referral_code}"
  end

  def shares_count
    0
  end

  def wall_posts
    []
  end

end

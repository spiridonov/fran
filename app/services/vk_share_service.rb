class VkShareService

  def initialize(user)
    @user = user
  end

  def link_for_sharing
    @link ||= "http://spiridonov.pro/?ref=#{@user.referral_code}"
  end

  def shares_count
    conn = Faraday.new(url: 'https://vk.com') do |faraday|
      faraday.adapter Faraday.default_adapter
    end

    query = {
      act: 'count',
      url: link_for_sharing
    }

    response = conn.get("/share.php?#{query.to_query}")
    if response.body =~ /VK\.Share\.count\(\d+, (\d+)\);/i
      $1.to_i
    else
      0
    end
  end

  def wall_posts
    api = VK::Application.new(version: '5.37', access_token: @user.vk_token)

    result = api.vk_call('wall.get', {owner_id: @user.vk_id, filter: 'owner', offset: 0, count: 100})

    shares = result['items'].select do |post|
      post.fetch('attachments', []).any? do |attachment|
        attachment['type'] == 'link' && attachment['link']['url'] == link_for_sharing
      end
    end

    shares.map do |s|
      {
        comments: s["comments"]["count"], 
        likes: s["likes"]["count"],
        reposts: s["reposts"]["count"],
        datetime: Time.at(s["date"].to_i).to_datetime,
      }
    end
  end

end

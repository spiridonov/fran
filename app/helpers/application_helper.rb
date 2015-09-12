module ApplicationHelper

  def vk_url_with_name(user)
    if user.vk_id.present?
      url = "http://vk.com/id#{user.vk_id}"
      link_to user.name, url, target: '_blank'
    end
  end

  def fb_url_with_name(user)
    if user.fb_id.present?
      url = "https://www.facebook.com/app_scoped_user_id/#{user.fb_id}"
      link_to user.name, url, target: '_blank'
    end
  end

  def vk_url(user)
    if user.vk_id.present?
      url = "http://vk.com/id#{user.vk_id}"
      link_to url, target: '_blank' do
        concat "VK "
        concat tag(:span, class: "glyphicon glyphicon-share-alt")
      end
    end
  end

  def fb_url(user)
    if user.fb_id.present?
      url = "https://www.facebook.com/app_scoped_user_id/#{user.fb_id}"
      link_to url, target: '_blank' do
        concat "Facebook "
        concat tag(:span, class: "glyphicon glyphicon-share-alt")
      end
    end
  end

  def social_url_with_name(user)
    if user.vk_id.present?
      vk_url_with_name(user)
    else
      fb_url_with_name(user)
    end
  end

  def social_url(user)
    if user.vk_id.present?
      vk_url(user)
    else
      fb_url(user)
    end
  end  

  def week_day(n)
    ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'][n - 1]
  end

  def share_link(user)
    if user.vk_id.present?
      vk_share_link(user)
    else
      fb_share_link(user)
    end
  end

  def fb_share_link(user)
    
  end

  def vk_share_link(user)
    query = {
      url: "http://spiridonov.pro/?ref=#{user.referral_code}",
      noparse: true,
      title: 'Test',
      description: '#test',
      # image: ''
    }
    link_to "Расскажу друзьям!", "http://vk.com/share.php?#{query.to_query}", class: 'btn btn-md btn-success'
  end

end

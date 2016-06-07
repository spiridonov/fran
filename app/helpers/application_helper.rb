module ApplicationHelper

  def vk_url_with_name(user)
    if user.vk_id.present?
      url = vk_url(user)
      link_to user.name, url, target: '_blank'
    end
  end

  def fb_url_with_name(user)
    if user.fb_id.present?
      url = fb_url(user)
      link_to user.name, url, target: '_blank'
    end
  end

  def vk_link(user)
    if user.vk_id.present?
      url = vk_url(user)
      link_to url, target: '_blank' do
        concat "VK "
        concat tag(:span, class: "glyphicon glyphicon-share-alt")
      end
    end
  end

  def vk_url(user)
    "http://vk.com/id#{user.vk_id}"
  end

  def fb_url(user)
    "https://www.facebook.com/app_scoped_user_id/#{user.fb_id}"
  end  

  def fb_link(user)
    if user.fb_id.present?
      url = fb_url(user)
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

  def social_link(user)
    if user.vk_id.present?
      vk_link(user)
    else
      fb_link(user)
    end
  end  

  def week_day(n)
    ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'][n - 1]
  end

  def share_link(user, box, classes = nil)
    if user.vk_id.present?
      vk_share_link(user, box, classes)
    else
      fb_share_link(user, box, classes)
    end
  end

  def fb_share_link(user, box, classes)
    if box.social_url.present?
      query = {
        u: box.social_url,
        t: box.social_title,
      }
      link_to "Расскажу друзьям!", "https://www.facebook.com/sharer/sharer.php?#{query.to_query}", 
        class: "btn btn-md btn-primary  #{classes}", target: '_blank',
        onclick: "javascript:window.open(this.href, '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=300,width=600');return false;"
    end
  end

  def vk_share_link(user, box, classes)
    if box.social_url.present?
      query = {
        url: box.social_url,
        noparse: true,
        title: box.social_title,
        description: box.social_description,
        image: URI.join(root_url, box.social_image.url) 
      }
      link_to "Расскажу друзьям!", "http://vk.com/share.php?#{query.to_query}", 
        class: "btn btn-md btn-primary #{classes}", target: '_blank',
        onclick: "javascript:window.open(this.href, '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=300,width=600');return false;"
    end
  end

  def workout_color_class(color)
    case color
    when 1
      'btn-default'
    when 2
      'btn-success'
    when 3
      'btn-danger'
    when 4
      'btn-warning'
    when 5
      'btn-primary'
    when 6
      'btn-info'
    else
      'btn-default'
    end
  end

  def color_collection
    [
      ['Серый', 1],
      ['Зеленый', 2], 
      ['Красный', 3],
      ['Желтый', 4],
      ['Синий', 5],
      ['Голубой', 6]
    ]
  end
end

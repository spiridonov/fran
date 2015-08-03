module ApplicationHelper

  def vk_url(user)
    if user.vk_id.present?
      url = "http://vk.com/id#{user.vk_id}"
      name = "vk.com/id#{user.vk_id}"
      link_to name, url, target: '_blank'
    end
  end

  def vk_url_with_name(user)
    if user.vk_id.present?
      url = "http://vk.com/id#{user.vk_id}"
      link_to user.name, url, target: '_blank'
    end
  end

  def week_day(n)
    ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'][n - 1]
  end

end

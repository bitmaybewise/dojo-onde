module DojosHelper
  def participate_button(user, dojo = @dojo)
    if dojo.has_participant?(user)
      link_to(t('helpers.dojos.participate_button.participate_no'), quit_dojo_path(dojo), method: :put, class: "btn btn-danger btn-block")
    elsif dojo.reached_limit?
      content_tag(:div, t('helpers.dojos.participate_button.participate_reached_limit'), class: "well")
    else
      link_to(t('helpers.dojos.participate_button.participate_yes'), participate_dojo_path(dojo), method: :put, class: "btn btn-success btn-block")
    end
  end

  def gravatar_url(user, size=nil)
    if user.try(:email)
      gravatar_id = Digest::MD5.hexdigest(user.email)
      "https://www.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    else
      image_url("blank-avatar.jpg")
    end
  end
end

module DojosHelper
  def participate_button(user, dojo = @dojo)
    user && user.participate?(dojo) ?
      link_to("Desistir :(", quit_dojo_path(dojo), method: :put, class: "btn btn-danger btn-block") :
      link_to("Eu vou!", participate_dojo_path(dojo), method: :put, class: "btn btn-success btn-block")
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

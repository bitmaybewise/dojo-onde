module DojosHelper
  def participate_button(user, dojo = @dojo)
    user && user.participate?(dojo) ?
      link_to("Desistir :(", dojo_quit_path(dojo), method: :put, class: "btn btn-danger btn-block") :
      link_to("Eu vou!", dojo_participate_path(dojo), method: :put, class: "btn btn-success btn-block")
  end
end

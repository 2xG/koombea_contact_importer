module ApplicationHelper
  def current_controller?(name)
    name.to_sym == controller_name.to_sym
  end
end

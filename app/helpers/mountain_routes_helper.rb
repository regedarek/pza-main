module MountainRoutesHelper
  def team_link(route)
    [link_to(route.user.name, user_path(route.user)), route.partner].reject(&:empty?).compact.join(' + ').strip
  end
end

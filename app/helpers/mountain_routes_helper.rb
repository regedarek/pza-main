module MountainRoutesHelper
  def team_link(route)
    [
      link_to(
        route.user.name,
        user_path(route.user),
        class: "rounded-lg text-blue-500 inline-block font-medium"
      ),
      route.partner
    ].reject(&:empty?).compact.join(' + ').strip
  end
end

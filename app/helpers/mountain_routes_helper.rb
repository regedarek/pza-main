module MountainRoutesHelper
  def team_link(route)
    [
      route.partners.map { |partner| link_to(partner.name, user_path(partner), class: "rounded-lg text-blue-500 inline-block font-medium") }
    ].flatten.reject(&:empty?).compact.join(' + ').strip
  end
end

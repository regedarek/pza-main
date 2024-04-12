# == Schema Information
#
# Table name: mountain_route_partners
#
#  id                :uuid             not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  mountain_route_id :uuid             not null
#  user_id           :uuid             not null
#
# Indexes
#
#  index_mountain_route_partners_on_mountain_route_id              (mountain_route_id)
#  index_mountain_route_partners_on_mountain_route_id_and_user_id  (mountain_route_id,user_id) UNIQUE
#  index_mountain_route_partners_on_user_id                        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (mountain_route_id => mountain_routes.id)
#  fk_rails_...  (user_id => users.id)
#
class MountainRoutePartner < ApplicationRecord
  belongs_to :mountain_route
  belongs_to :user

  validates :mountain_route, presence: true
  validates :user, presence: true
  validates :user_id, uniqueness: { scope: :mountain_route_id }
end

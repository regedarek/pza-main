# == Schema Information
#
# Table name: users
#
#  id              :uuid             not null, primary key
#  admin           :boolean          default(FALSE)
#  email           :string
#  first_name      :string
#  last_name       :string
#  last_sport_type :string
#  password_digest :string
#  slug            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_slug  (slug) UNIQUE
#
class User < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end

  has_secure_password

  normalizes :email, with: -> (email) { email.strip.downcase }

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :added_mountain_routes, dependent: :destroy, class_name: 'MountainRoute', foreign_key: :user_id

  has_many :mountain_route_partners, dependent: :destroy
  has_many :mountain_routes, through: :mountain_route_partners, source: :mountain_route

  def name
    "#{first_name} #{last_name}"
  end

  def title
    "-"
  end

  def club
    "-"
  end
end

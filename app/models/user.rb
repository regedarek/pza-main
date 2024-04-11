# == Schema Information
#
# Table name: users
#
#  id              :uuid             not null, primary key
#  admin           :boolean          default(FALSE)
#  email           :string
#  first_name      :string
#  last_name       :string
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

  has_one_attached :avatar
  has_secure_password

  normalizes :email, with: -> (email) { email.strip.downcase }

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :mountain_routes, dependent: :destroy

  def admin?
    false
  end

  def name
    "#{first_name} #{last_name}"
  end
end

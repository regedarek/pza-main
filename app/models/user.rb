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
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  has_secure_password

  normalizes :email, with: [:strip, :downcase]

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  def admin?
    admin
  end
  
  def name
    "#{first_name} #{last_name}"
  end
end

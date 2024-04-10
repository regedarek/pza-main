# == Schema Information
#
# Table name: users
#
#  id               :uuid             not null, primary key
#  email            :string
#  first_name       :string
#  last_name_string :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
end

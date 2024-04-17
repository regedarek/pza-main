# == Schema Information
#
# Table name: app_settings
#
#  id           :uuid             not null, primary key
#  checkbox     :boolean          default(FALSE), not null
#  name         :string           not null
#  number       :integer
#  setting_type :integer          default("content"), not null
#  slug         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_app_settings_on_slug  (slug) UNIQUE
#
class AppSetting < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_rich_text :content

  enum setting_type: {
    content: 0, checkbox: 1, number: 2
  }

  validates :slug, presence: true, uniqueness: true
  validates :name, presence: true

  validates :number, presence: true, if: -> { self.setting_type == 'number' }
  validates :content, presence: true, if: -> { self.setting_type == 'content' }
  validates :checkbox, inclusion: { in: [true, false] }, if: -> { self.setting_type == 'checkbox' }
end

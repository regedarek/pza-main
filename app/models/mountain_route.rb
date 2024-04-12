# == Schema Information
#
# Table name: mountain_routes
#
#  id                    :uuid             not null, primary key
#  activity_date         :date
#  area                  :string
#  custom_difficulty     :string
#  equipped              :boolean
#  french_difficulty     :integer
#  length                :integer
#  multipitch            :boolean
#  multipitch_difficulty :string
#  multipitch_lead       :integer
#  multipitch_number     :integer
#  multipitch_style      :integer
#  name                  :string
#  partner               :string
#  slug                  :string
#  sport_type            :integer          not null
#  style                 :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  user_id               :uuid             not null
#
# Indexes
#
#  index_mountain_routes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class MountainRoute < ApplicationRecord
  include PgSearch::Model
  extend FriendlyId

  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [150, 150]
  end

  has_rich_text :description

  pg_search_scope :search,
    against: [:name, :area, :partner],
    associated_against: {
      user: [:first_name, :last_name],
      rich_text_description: [:body]
    },
    using: [:tsearch]

  friendly_id :name_and_date, use: :slugged

  enum sport_type: {
    trad_climbing: 0, speleo: 1, skimo: 2, winter_climbing: 3, sport_climbing: 4
  }

  enum multipitch_style: {
    'OS': 0, 'RP': 1, 'FL': 2, 'AF': 3
  }, _prefix: :multipitch

  enum style: {
    'OS': 0, 'RP': 1, 'FL': 2, 'AF': 3
  }
  enum french_difficulty: {
    '1': 0, '2': 1, '2+': 2, '3': 3, '4a': 4, '4b': 5, '4c': 6, '5a': 7,
    '5b': 8, '5c': 9, '6a': 10, '6a+': 11, '6b': 12, '6b+': 13, '6c': 14,
    '6c+': 15, '7a': 16, '7a+': 17, '7b': 18, '7b+': 19, '7c': 20, '7c+': 21,
    '8a': 22, '8a+': 23, '8b': 24, '8b+': 25, '8c': 26, '8c+': 27, '9a': 28,
    '9a+': 29, '9b': 30, '9b+': 31
  }

  belongs_to :user

  validates :user_id, :activity_date, :sport_type, :name, :area, :length, :french_difficulty,
    :style, presence: true

  validates :multipitch_style, :multipitch_number, :multipitch_lead,
    :multipitch_difficulty, :partner, presence: true, if: :multipitch

  validates :equipped, inclusion: { in: [true, false], message: I18n.t('errors.messages.blank') }
  validates :multipitch, inclusion: { in: [true, false], message: I18n.t('errors.messages.blank') }

  validates :multipitch_style, inclusion: { in: multipitch_styles.keys }, if: :multipitch
  validates :style, inclusion: { in: styles.keys }
  validates :french_difficulty, inclusion: { in: french_difficulties.keys }

  def name_and_date
    return nil unless activity_date.present? && name.present?

    "#{activity_date&.to_date} #{name}"
  end

  def team
    [user.name, partner].reject(&:empty?).compact.join(' + ').strip
  end
end

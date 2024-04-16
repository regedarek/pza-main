# == Schema Information
#
# Table name: messaging_comments
#
#  id               :uuid             not null, primary key
#  commentable_type :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_id   :uuid             not null
#  user_id          :uuid             not null
#
# Indexes
#
#  index_messaging_comments_on_commentable  (commentable_type,commentable_id)
#  index_messaging_comments_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Messaging::Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :content, presence: true

  has_rich_text :content
end

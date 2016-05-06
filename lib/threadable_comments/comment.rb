require 'ancestry'

module ThreadableComments
  class Comment < ActiveRecord::Base
    has_ancestry orphan_strategy: :destroy
    default_scope { order(created_at: :desc) }

    validates :commentable, presence: true
    validates :user, presence: true

    belongs_to :commentable, polymorphic: true
    belongs_to :user
    serialize :parameters

    def reply(text, user)
      Comment.create \
      commentable: commentable,
      text: text,
      user_id: user.id,
      parent: self
    end

    # Scope to find all comments for specific user
    scope :by_user, lambda { |user|
      raise ArgumentError.new("User must have an ID property") unless user.respond_to? :id

      where(user_id: user.id)
    }

  end
end

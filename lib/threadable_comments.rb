require 'active_record'

require_relative 'threadable_comments/version'
require_relative 'threadable_comments/comment'

module ThreadableComments
  extend ActiveSupport::Concern

  module ClassMethods
    def has_threadable_comments
      has_many :comments, -> {order('created_at DESC')}, as: :commentable, dependent: :destroy
      include ThreadableComments::InstanceMethods
    end
  end

  module InstanceMethods
    # Scope comments to only root threads, no children/replies
    def root_comments
      comments.roots
    end

    # scope comments to specific user
    def comments_by(user)
      raise ArgumentError.new("User must have an ID property") unless user.respond_to? :id

      comments.where(user_id: user.id).order('created_at DESC')
    end

    def add_comment(text, user)
      new_comment = Comment.create(commentable: self, text: text, user_id: user.id)
      comments << new_comment
      new_comment
    end
  end

end

ActiveRecord::Base.send(:include, ThreadableComments)

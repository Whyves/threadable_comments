require 'active_record'
require 'threadable_comments/version'
require 'threadable_comments/comment'

module ThreadableComments
  extend ActiveSupport::Concern

  module ClassMethods
    def has_threadable_comments
      has_many :comments, class_name: '::ThreadableComments::Comment', as: :commentable, dependent: :destroy
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

      comments.where(user_id: user.id)
    end

    def add_comment(text, user, parameters = {})
      new_comment = ThreadableComments::Comment.create(commentable: self,
                                                       text: text,
                                                       user_id: user.id,
                                                       parameters: parameters)
      comments << new_comment
      new_comment
    end
  end

end

ActiveRecord::Base.send(:include, ThreadableComments)

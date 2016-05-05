require 'active_record'
require 'threadable_comments'

class User < ActiveRecord::Base
  has_many :comments
end

class Commentable < ActiveRecord::Base
  has_threadable_comments
end

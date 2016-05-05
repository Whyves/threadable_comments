Threadable Comments
===================

Allows for threaded comments to be added to different models while comment hierarchy is handled via the [ancestry gem](https://github.com/stefankroes/ancestry) (uses a materialised path pattern).

Install
-------
In your Gemfile, add:

    gem 'threadable_comments'

and run `bundle install`.

Migrations
----------
* To install:

        rails generate threadable_comments_migration

    This will generate the migration script necessary for the table

Usage
-----
    class Article < ActiveRecord::Base
      has_threadable_comments
    end

* Add a comment to a model instance, for example an Article:

        @user_who_commented = @current_user
        @article.add_comment "This is my comment!", @user_who_commented

* To reply to a comment:

        @comment.reply = "This is a reply!", @user_who_commented

* To retrieve all comments for an article, including child comments:

        @all_comments = @article.comments

* To retrieve only the root comments without their child comments:

        @root_comments = @article.root_comments

* To check if a comment has children:

        @comment.has_children?

* To get a comment's parent:

        @comment.parent

* To verify the number of direct children a comment has:

        @comment.children.count

* To verify the number of children and grand-children a comment has:

        @comment.descendants.count

* To retrieve a comment's children:

        @comment.children

Tips
----
Once you have a comment in your hands, you can use all the methods and scope of the [ancestry gem](https://github.com/stefankroes/ancestry) to access children and parents of the comment.

Credits
-------
* Inspired from [act_as_commentable_with_threading](https://github.com/elight/acts_as_commentable_with_threading)


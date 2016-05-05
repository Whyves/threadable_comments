require 'rspec'

describe ThreadableComments do

  describe 'A class that is commentable' do
    let(:user) {User.create!}
    let(:other_user) {User.create!}
    let(:commentable) {Commentable.create!}
    let(:other_commentable) {Commentable.create!}

    before(:example) do
      commentable.add_comment('This is my comment', user).reply('And this is the reply', user)
      commentable.add_comment('This is another comment', user).reply('And this is its reply', user)
      other_commentable.add_comment('Yet another comment', other_user)
    end

    after(:example) do
      Comment.destroy_all
    end

    it 'can be commented upon' do
      last_comment = commentable.comments.last
      expect(last_comment.text).to eq('This is my comment')
      expect(last_comment.commentable).to eq(commentable)
      expect(last_comment.user_id).to eq(user.id)
    end

    it 'lists the comments by creation date' do
      expect(commentable.comments.first.text).to eq('And this is its reply')
    end

    it 'can retrieve root comments only' do
      expect(commentable.root_comments.count).to eq(2)
    end

    it 'can retrieve comments made by a specific user' do
      commentable.root_comments.first.reply('Other user reply', other_user)

      expect(commentable.comments.count).to eq(5)
      expect(commentable.comments_by(other_user).count).to eq(1)
    end

    describe 'when it is destroyed' do
      it 'destroys its own root comments along with their children' do
        expect{commentable.destroy}.to change{Comment.count}.by(-4)
      end

      it 'does not destroy other root comments' do
        commentable.destroy
        expect(Comment.count).to eq(1)
      end
    end
  end
end
require 'rspec'

describe Comment do

  let(:user) {User.create!}
  let(:commentable) {Commentable.create!}

  let(:comment) {Comment.create(commentable: commentable, user: user, text: 'This is a comment')}

  after(:example) do
    Comment.destroy_all
  end


  it 'should validate a commentable' do
    comment.commentable = nil

    expect(comment.valid?).to be_falsey
  end

  it 'should validate the presence of user' do
    comment.user = nil

    expect(comment.valid?).to be_falsey
  end

  it 'can be replied to' do
    new_comment = comment.reply('this is a reply!', user)
    comment.reply('this is another reply!', user)

    expect(new_comment.parent).to eq(comment)
    expect(comment.children.count).to eq(2)
  end

  it 'can have reply to a reply' do
    new_comment = comment.reply('this is a reply!', user).reply('this is a sub reply!', user)

    expect(comment.descendants.count).to eq(2)
  end

  it 'destroys all of its children and their descendants' do
    comment.reply('this is a reply!', user).reply('this is a sub reply!', user)

    expect{comment.destroy}.to change{Comment.count}.by(-3)
  end

  it 'retrieves all comments for a particular user' do
    other_user = User.create!
    comment.reply('this is a reply!', user)
    comment.reply('this is the other user reply!', other_user)

    expect(Comment.count).to eq(3)
    expect(Comment.by_user(other_user).count).to eq(1)
    expect(Comment.by_user(user).count).to eq(2)
  end

end
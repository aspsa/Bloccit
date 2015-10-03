require 'rails_helper'

describe Post do
    describe "vote methods" do
       before do
           # Checkpoint #53 - Voting
           #
           # The three tests below fail, because the Post's 'body' attribute value is not a minimum of twenty characters long. This is not evident in the RSpec error message, which simply states "You cannot call crete unless the parent is saved." Tracing the error requires some digging. The following stament in the Post model provides the root cause of the RSpec error:
           #
           #        validates :body, length: { minimum: 20 }, presence: true
           #
           # @post = Post.create(title: 'post title', body: 'post body')
           #
           # Note: Checkpoint #53 - Voting implies that correcting the Post creation statement such that its 'body' attribute value passess the Post model's validation statement corrects this problem, although the RSpec validation test still fails for Votes.
           #
           #        "If you run the spec again, the validations for the
           #        presence of user and topic will also fail."
           @post = Post.create(title: 'post title', body: 'Post bodies must be pretty long.')
           3.times { @post.votes.create(value: 1) }
           2.times { @post.votes.create(value: -1) }
       end
       
       describe '#up_votes' do
          it "counts the number of votes with value = 1" do
            expect( @post.up_votes ).to eq(3)
          end
       end
       
       describe '#down_votes' do
          it "counts the number of votes with value = -1" do
             expect( @post.down_votes ).to eq(2) 
          end
       end
       
       describe '#points' do
          it "returns the sum of all down and up votes" do
              expect( @post.points ).to eq(1)   # 3 - 2
          end
       end
    end
end
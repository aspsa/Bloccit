# Assignment #52 - Intro to RSpec
#
# Dalibor's comment:
#      - Vote specs are not OK, try to fix them. If you do not manage it on your own, we are going to fix them after we introduce Vote model.


# Assignment #52 - Intro to RSpec
#
# Since the intent for Test-Driven Development is to keep the tests as low-level as possible, the idea is to remove any dependencies to other Models. I assume this is a best practice. I also assume that if one referenced another model (e.g., the 'Post' model), that this RSpec file would have to somehow import the 'Post' RSpec file. Since this dependency is not asserted, then I assume it is sufficient to only require 'rails_helper' for RSpec testing purposes.
=begin
require 'rails_helper'

describe Vote do
describe "validations" do
       # Assignment #52 - Intro to RSpec
       #
       # I added an underscore to 'value validation' in order to follow the proper naming convention. Also, I assume that this functionality is best built in as an instance method and not as a class method, which is why the method name is preceded with a hash symbol. One assumes the 'Vote' model will be instantiated and assigned to an object instance variable. As with the 'Post' model RSpec test, perhaps this would be done in a 'before' block, as in the following example.
       #
       # before do
       #    @vote = Vote.create(value_validation: 0)
       # end
       #
       # Given the checkpoint's discussion on 'Red, Green, Refactor', I assume the 'Vote' object instance variable should hold a reference to a 'Vote' object that has a 'value_validation' value that initially intensionally fails the '#value_validation' RSpec test.
       describe "#value_validation" do
           it "only allows -1 or 1 as values" do
               expect( @vote.value_validation ).to eq(-1)
               expect( @vote.value_validation ).to eq(1)
           end
       end
    end
end
=end

# Assignment #52 - Intro to RSpec
#
# Dalibor's comments:
#      - You need to enter specific expectations in your tests. One of the possible solutions:

describe Vote do
  describe "validations" do
    it "only allows -1 or 1 as values" do
      up_vote = Vote.new(value: 1)
      expect(up_vote.valid?).to be_true

      down_vote = Vote.new(value: -1)
      expect(down_vote.valid?).to be_true

      invalid_vote = Vote.new(value: 2)
      expect(invalid_vote.valid?).to be_false
    end
  end
end
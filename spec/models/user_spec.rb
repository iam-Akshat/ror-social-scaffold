require_relative '../rails_helper.rb'

RSpec.describe User do 
    context "validations" do
        it 'is false when name is not assigned to user' do
            user = User.new
            expect(user.valid?).to be false
        end
    end

    context "assosciations" do
         it { should have_many(:posts).class_name('Post') }
         it { should have_many(:likes).class_name('Like') }
         it { should have_many(:comments).class_name('Comment') }
         it { should have_many(:friendships).class_name('Friendship') }
         it { should have_many(:recieved_friends) }
    end
end
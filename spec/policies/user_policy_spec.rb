require "rails_helper"
require "pundit/rspec"

describe UserPolicy do
  subject { UserPolicy }
  
  context "for a regular user" do
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    
    permissions :index? do
      it "should not allow regular users to view the user index" do
        expect(subject).to_not permit(user)
      end
    end
    
    permissions :show? do
      it "should allow regular users to view other users" do
        expect(subject).to permit(user, user2)
      end
    end
    
    permissions :create? do
      it "should not allow regular users to create users" do
        expect(subject).to_not permit(user)
      end
    end
    
    permissions :update? do
      it "should allow regular users to update themselves" do
        expect(subject).to permit(user, user)
      end
      
      it "should not allow regular users to update other users" do
        expect(subject).to_not permit(user, user2)
      end
    end
    
    permissions :friends? do
      it "should allow regular users to view their friends" do
        expect(subject).to permit(user, user)
      end
      
      it "should allow regular users to view other user's friends" do
        expect(subject).to permit(user, user2)
      end
    end
    
    permissions :add_friend? do
      it "should allow regular users to add friends" do
        expect(subject).to permit(user, user)
      end
      
      it "should not allow regular users to make other users add friends" do
        expect(subject).to_not permit(user, user2)
      end
    end
    
    permissions :remove_friend? do
      it "should allow regular users to remove friends" do
        expect(subject).to permit(user, user)
      end
      
      it "should not allow regular users to make other users remove friends" do
        expect(subject).to_not permit(user, user2)
      end
    end
    
    permissions :destroy? do
      it "should allow regular users to delete themselves" do
        expect(subject).to permit(user, user)
      end
      
      it "should not allow regular users to delete other users" do
        expect(subject).to_not permit(user, user2)
      end
    end
    
    permissions :show? do
      it "should allow regular users to view other users" do
        expect(subject).to permit(user, user2)
      end
    end
  end
end
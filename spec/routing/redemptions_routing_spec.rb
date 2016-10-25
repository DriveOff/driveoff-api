require "rails_helper"

RSpec.describe RedemptionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/users/1/redemptions").to route_to("redemptions#index", :user_id => "1", format: "json")
    end

    it "routes to #show" do
      expect(:get => "/users/1/redemptions/1").to route_to("redemptions#show", :id => "1", :user_id => "1", format: "json")
    end

    it "routes to #create" do
      expect(:post => "/users/1/redemptions").to route_to("redemptions#create", :user_id => "1", format: "json")
    end

    it "routes to #update via PUT" do
      expect(:put => "/users/1/redemptions/1").to route_to("redemptions#update", :id => "1", :user_id => "1", format: "json")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/users/1/redemptions/1").to route_to("redemptions#update", :id => "1", :user_id => "1", format: "json")
    end

    it "routes to #destroy" do
      expect(:delete => "/users/1/redemptions/1").to route_to("redemptions#destroy", :id => "1", :user_id => "1", format: "json")
    end

  end
end

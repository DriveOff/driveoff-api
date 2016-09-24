require "rails_helper"

RSpec.describe RedemptionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/redemptions").to route_to("redemptions#index")
    end

    it "routes to #new" do
      expect(:get => "/redemptions/new").to route_to("redemptions#new")
    end

    it "routes to #show" do
      expect(:get => "/redemptions/1").to route_to("redemptions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/redemptions/1/edit").to route_to("redemptions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/redemptions").to route_to("redemptions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/redemptions/1").to route_to("redemptions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/redemptions/1").to route_to("redemptions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/redemptions/1").to route_to("redemptions#destroy", :id => "1")
    end

  end
end

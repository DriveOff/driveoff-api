require "rails_helper"

RSpec.describe TripsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/users/1/trips").to route_to("trips#index", :user_id => "1", format: "json")
    end

    it "routes to #show" do
      expect(:get => "/users/1/trips/1").to route_to("trips#show", :id => "1", :user_id => "1", format: "json")
    end

    it "routes to #create" do
      expect(:post => "/users/1/trips").to route_to("trips#create", :user_id => "1", format: "json")
    end

    it "routes to #update via PUT" do
      expect(:put => "/users/1/trips/1").to route_to("trips#update", :id => "1", :user_id => "1", format: "json")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/users/1/trips/1").to route_to("trips#update", :id => "1", :user_id => "1", format: "json")
    end

    it "routes to #destroy" do
      expect(:delete => "/users/1/trips/1").to route_to("trips#destroy", :id => "1", :user_id => "1", format: "json")
    end

  end
end

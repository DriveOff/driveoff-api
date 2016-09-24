require 'rails_helper'

RSpec.describe "Redemptions", type: :request do
  describe "GET /redemptions" do
    it "works! (now write some real specs)" do
      get redemptions_path
      expect(response).to have_http_status(200)
    end
  end
end

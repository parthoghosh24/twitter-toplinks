require 'rails_helper'

RSpec.describe AnalyticsController, type: :controller do

  describe "GET #store" do
    it "returns http success" do
      get :store
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #fetch_link_tweets" do
    it "returns http success" do
      get :fetch_link_tweets
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #top_user" do
    it "returns http success" do
      get :top_user
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #top_domains" do
    it "returns http success" do
      get :top_domains
      expect(response).to have_http_status(:success)
    end
  end

end

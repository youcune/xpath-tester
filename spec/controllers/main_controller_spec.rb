require 'spec_helper'

describe MainController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end
  end

  describe "GET 'exec'" do
    it "returns http success" do
      get 'exec'
      expect(response).to be_success
    end
  end

end

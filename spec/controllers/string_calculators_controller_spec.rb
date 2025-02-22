require 'rails_helper'

RSpec.describe StringCalculatorsController, type: :controller do
  describe "GET #add" do
    it "returns 0 for an empty string" do
      get :add, params: { numbers: "" }
      expect(JSON.parse(response.body)["result"]).to eq(0)
    end

    it "returns the sum of one number" do
      get :add, params: { numbers: "1" }
      expect(JSON.parse(response.body)["result"]).to eq(1)
    end

    it "returns the sum of two numbers" do
      get :add, params: { numbers: "1,5" }
      expect(JSON.parse(response.body)["result"]).to eq(6)
    end

    it "handles new lines as delimiters" do
      get :add, params: { numbers: "1\n2,3" }
      expect(JSON.parse(response.body)["result"]).to eq(6)
    end

    it "supports custom delimiters" do
      get :add, params: { numbers: "//;\n1;2" }
      expect(JSON.parse(response.body)["result"]).to eq(3)
    end

    it "raises an error for negative numbers" do
      expect {
        get :add, params: { numbers: "1,-2,3" }
      }.to raise_error("negative numbers not allowed -2")
    end
  end
end

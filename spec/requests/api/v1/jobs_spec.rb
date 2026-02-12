require 'rails_helper'

RSpec.describe "Api::V1::Jobs", type: :request do
  let(:common_user)     { create(:user) }
  let(:common_company)  { create(:company, user: common_user) }
  let(:common_industry) { create(:industry) }
  let(:common_city)     { create(:city) }

  let!(:jobs) do 
    create_list(:job, 25, 
      company: common_company, 
      industry: common_industry, 
      city: common_city
    ) 
  end
  describe "GET /api/v1/jobs" do
    # Happy path
    context "Correct Param" do
      it 'Return status code 200 and 20 first record ' do
        get '/api/v1/jobs', params: {page: 1}
  
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['data'].size).to eq(20)
      end
    end

    # Sad path
    context "Param page is string(abc)" do
      it "Auto return data of page 1" do
        get "/api/v1/jobs", params: { page: "abc" }
        
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        
        # Check 20 record of page 1 or not
        expect(json["data"].size).to eq(20)
      end 
    end

    context "Param page is negative (-1)" do
      it "Auto rerturn data of page 1" do
        get "/api/v1/jobs", params: { page: -1 }
        
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json["data"].size).to eq(20)
      end
    end
  end
end

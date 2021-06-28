require 'rails_helper'

RSpec.describe "Clothe",type: :request do
  describe 'POST #create' do
    it '服の登録に成功すること' do
      post clothe_path, params: { clothe: { kind:"1", color:"1", type:"1",image:"null"} }
      expect(response).to have_http_status(200)
    end
  end
end

require "rails_helper"

describe "Chirps API" do
  describe "GET /chirps" do
    let(:chirp_keys) {[:id, :text]}

    it "returns the chirps" do
      first_chirp = create(:chirp, text: "First chirp")
      second_chirp = create(:chirp)

      get("/chirpper/v1/chirps")

      expect(response.status).to eq(200)
      chirps_response = JSON.parse(response.body, symbolize_names: true)[:chirps]
      expect(chirps_response.map {|chirp| chirp[:id]}).to match_array([first_chirp.id, second_chirp.id])
      first_chirp_response = chirps_response.find {|chirp| chirp[:id] == first_chirp.id}
      expect(first_chirp_response.keys).to eq(chirp_keys)
      expect(first_chirp_response[:text]).to eq("First chirp")
    end
  end
end
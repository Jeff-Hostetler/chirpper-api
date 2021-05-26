require "rails_helper"

describe "Chirps API" do
  let(:chirp_keys) {[:id, :text, :upvotes]}

  describe "GET /chirps" do
    it "returns the popular chirps and normal chirps" do
      first_chirp = create(:chirp, text: "First chirp", created_at: 2.minutes.ago, upvotes: 10)
      second_chirp = create(:chirp, created_at: 1.minute.ago, upvotes: 9)
      old_popular = create(:chirp, created_at: 2.days.ago, upvotes: 100)
      not_as_old_not_popular = create(:chirp, created_at: 25.hours.ago, upvotes: 0)

      get("/chirpper/v1/chirps")

      expect(response.status).to eq(200)
      response_body = JSON.parse(response.body, symbolize_names: true)
      popular_chirps = response_body[:popular_chirps]
      expect(popular_chirps.map {|chirp| chirp[:id]}).to eq([first_chirp.id, second_chirp.id])
      first_chirp_response = popular_chirps.find {|chirp| chirp[:id] == first_chirp.id}
      # expect(first_chirp_response.keys).to eq(chirp_keys)
      expect(first_chirp_response[:text]).to eq("First chirp")

      chirps = response_body[:chirps]
      expect(chirps.map {|chirp| chirp[:id]}).to eq([not_as_old_not_popular.id, old_popular.id])
    end
  end

  describe "POST /chirps" do
    it "creates a new chirp" do
      stub_request(:post, "https://bellbird.joinhandshake-internal.com/push/").
        to_return(status: 200, body: "", headers: {})

      post("/chirpper/v1/chirps", params: {text: "test chirp"})

      expect(response.status).to eq(201)
      expect(Chirp.find_by(text: "test chirp")).to be_present
      chirp_response = JSON.parse(response.body, symbolize_names: true)[:chirp]
      expect(chirp_response.keys).to eq(chirp_keys)
      expect(chirp_response[:text]).to eq("test chirp")
      expect(chirp_response[:id]).to be_present
      expect(
        a_request(:post, "https://bellbird.joinhandshake-internal.com/push/")
      ).to have_been_made
    end
  end


  describe "POST /chirps/:id/upvote" do
    it "adds 1 to the upvote on a chirp" do
      chirp = create(:chirp, upvotes: 0)

      post("/chirpper/v1/chirps/#{chirp.id}/upvote")


      expect(response.status).to eq(200)
      chirp_response = JSON.parse(response.body, symbolize_names: true)[:chirp]
      expect(chirp_response.keys).to eq(chirp_keys)
      expect(chirp_response[:upvotes]).to eq(1)
    end
  end
end
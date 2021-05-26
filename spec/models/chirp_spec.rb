require "rails_helper"

describe Chirp do
  describe "validations" do
    it "does not allow a chirp over 140 characters" do
      too_long_chirp = described_class.new(text: ("a" * 141))

      expect(too_long_chirp.valid?).to eq(false)
      expect(too_long_chirp.errors.full_messages).to eq(["Our current chirp length is restricted to 140 characters."])
    end

    it "does allow a chirp of 140 characters" do
      too_long_chirp = described_class.new(text: ("a" * 140))

      expect(too_long_chirp.valid?).to eq(true)
    end
  end

  describe ".default_order" do
    it "returns chirps with most recently created on the top" do
      second_to_return = create(:chirp, created_at: 2.minutes.ago)
      first_to_return = create(:chirp, created_at: 1.minute.ago)

      expect(described_class.default_order).to eq([first_to_return, second_to_return])
    end
  end

  describe ".popular" do
    it "returns chirps ordered by upvotes that were created in the last day" do
      most_popular = create(:chirp, upvotes: 10, created_at: 23.hours.ago)
      not_as_popular = create(:chirp, upvotes: 9, created_at: 22.hours.ago)
      create(:chirp, upvotes: 900, created_at: 25.hours.ago)

      expect(described_class.popular).to eq([most_popular, not_as_popular])
    end
  end

  describe "#upvote" do
    it "increments the upvotes by 1" do
      chirp = create(:chirp)
      expect(chirp.reload.upvotes).to eq(0)

      chirp.upvote

      expect(chirp.reload.upvotes).to eq(1)
    end
  end
end
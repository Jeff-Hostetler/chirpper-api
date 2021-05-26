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
end
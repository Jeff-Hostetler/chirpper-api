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
end
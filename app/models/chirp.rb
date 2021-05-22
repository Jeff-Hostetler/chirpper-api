class Chirp < ApplicationRecord
  validate :correct_length


  private

  def correct_length
    if text.length > 140
      errors.add(:base, "Our current chirp length is restricted to 140 characters.")
    end
  end
end
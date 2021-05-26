class Chirp < ApplicationRecord
  scope :default_order, -> { order(created_at: :desc) }
  scope :popular, -> {where("created_at > ?", 24.hours.ago).order(upvotes: :desc)}

  validate :correct_length

  def upvote
    self.update_attributes!(upvotes: upvotes + 1)
  end

  private

  def correct_length
    if text.length > 140
      errors.add(:base, "Our current chirp length is restricted to 140 characters.")
    end
  end
end
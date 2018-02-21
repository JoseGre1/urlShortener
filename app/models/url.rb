class Url < ApplicationRecord
  START_SEED = 500_000
  extend FriendlyId

  friendly_id :code

  after_create :encode_original

  VALID_URL_REGEX = URI.regexp(%w[http https])
  validates :original, presence: true, allow_blank: false,
                       format: { with: VALID_URL_REGEX }

  private

  def encode_original
    self.code = (START_SEED + id).to_s(36)
    save!
  end
end

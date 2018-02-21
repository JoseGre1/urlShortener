class Url < ApplicationRecord
  START_SEED = 500_000
  extend FriendlyId

  friendly_id :code

  after_create :encode_original

  validates :original, presence: true, allow_blank: false,
                       format: { with: %r(/(http|https):\/\/|[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?/ix) }

  private

  def encode_original
    self.code = (START_SEED + id).to_s(36)
    save!
  end
end

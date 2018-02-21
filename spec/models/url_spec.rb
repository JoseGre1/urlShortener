require "rails_helper"

RSpec.describe Url, type: :model do
  describe "original" do
    it { should validate_presence_of(:original) }
    it { should_not allow_value("").for(:original) }
    it { should allow_value("http://example.com/?foo=bar").for(:original) }
    it { should allow_value("https://example:3000").for(:original) }
    it { should allow_value("www.example.com").for(:original) }
    it { should allow_value("example.com").for(:original) }
  end

  describe "code" do
    it "is generated after create" do
      url = create(:url)
      expect(url.code.nil?).not_to be_nil
    end
  end
end

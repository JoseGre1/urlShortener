require "rails_helper"

RSpec.describe Url, type: :model do
  describe "original" do
    it { should validate_presence_of(:original) }
    it { should_not allow_value("").for(:original) }
    it { should allow_value("http://example.com").for(:original) }
    it { should allow_value("https://example.com").for(:original) }
    it { should allow_value("http://sub.example.com").for(:original) }
    it { should allow_value("http://sub.domain.my-example.com").for(:original) }
    it { should allow_value("http://example.com/?stuff=true").for(:original) }
    it { should allow_value("http://example.com:5000/?stuff=true").for(:original) }
    it { should allow_value("http://sub.domain.my-example.com/path/to/file/hello.html").for(:original) }
    it { should allow_value("http://hello.museum").for(:original) }
    it { should_not allow_value("example.com").for(:original) }
  end

  describe "code" do
    it "is generated after create" do
      url = create(:url)
      expect(url.code.nil?).not_to be_nil
    end
  end
end

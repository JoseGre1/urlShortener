require "rails_helper"

RSpec.describe "Page management", type: :request do
  describe "Home" do
    before { visit root_path }
    it "returns index page" do
      expect(page.has_selector?("h1", text: I18n.t("views.pages.home.title")))
    end
  end
end

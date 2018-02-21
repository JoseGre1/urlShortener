require "rails_helper"

RSpec.describe "URL management", type: :request do
  describe "#create" do
    context "when sent body is valid" do
      before(:all) do
        @old_url = create(:url)
        new_url = build(:url).as_json.slice("original")
        post api_v1_urls_url, params: { url: new_url }
      end

      it_should_behave_like "all successful endpoints"

      it "creates an URL" do
        expect(JSON.parse(response.body)["id"]).to be(@old_url.id + 1)
      end

      it "returns json with valid keys" do
        expect(JSON.parse(response.body).keys).to match_array %W[id original shortened_url]
      end
    end

    context "when sent body is invalid" do
      it "returns an UNPROCESSABLE ENTITY (422) status code" do
        post api_v1_urls_url, params: { url: {original: ""} }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "#show" do
    context "when resource is found" do
      before(:all) do
        url = create(:url)
        get api_v1_url_url(url.id)
      end

      it_should_behave_like "all successful endpoints"

      it "returns json with valid keys" do
        expect(JSON.parse(response.body).keys).to match_array %W[id original shortened_url]
      end
    end
    context "when resource is not found" do
      before(:all) do
        get api_v1_url_url(-1)
      end

      it "redirects to 404 page" do
        expect(subject).to redirect_to("/404.html")
      end
    end
  end

  describe "#redirect" do
  context "when sent code is valid" do
    before(:all) do
      @url = create(:url)
      get "/#{@url.code}"
    end

    it "redirects to original url" do
      expect(subject).to redirect_to(@url.original)
    end
  end

  context "when sent body is invalid" do
    it "returns an UNPROCESSABLE ENTITY (422) status code" do
      post api_v1_urls_url, params: { url: {original: ""} }
      expect(response.status).to eq(422)
    end
  end
end
end

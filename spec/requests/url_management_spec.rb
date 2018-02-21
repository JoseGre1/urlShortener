require "rails_helper"

RSpec.describe "Message management", type: :request do
  describe "#show" do
    it "returns a message" do
      message = create(:message)
      get api_v1_message_url(message.id)
      expect(JSON.parse(response.body)["id"]).to be(message.id)
      expect(response.status).to be(200)
    end
  end

  describe "#index" do
    before(:each) do
      @message1 = create(:message)
      @message2 = create(:message)
    end

    it "returns all messages" do
      get api_v1_messages_url
      expect(JSON.parse(response.body).pluck("id"))
        .to include(@message1.id, @message2.id)
      expect(response.status).to be(200)
    end

    it "returns nearest message to specified location" do
      location = [Faker::Address.latitude, Faker::Address.longitude].map(&:to_f)
      params = { search_by: "closest", latitude: location[0], longitude: location[1] }
      nearest = [@message1, @message2].sort_by { |m| m.distance_to(location) }.first
      get api_v1_messages_url, params: params
      expect(JSON.parse(response.body)["id"])
        .to be(nearest.id)
      expect(response.status).to be(200)
    end

    it "returns all messages in specified area" do
      location = [@message1.latitude, @message1.longitude].map(&:to_f)
      params = { search_by: "area", latitude: location[0], longitude: location[1], radius: 100.0 }
      get api_v1_messages_url, params: params
      expect(JSON.parse(response.body).pluck("id").map(&:to_i))
        .to include(@message1.id)
      expect(response.status).to be(200)
    end
  end

  describe "#create" do
    it "creates a new message" do
      old_message = create(:message)
      new_message = build(:message).as_json.except("id", "created_at", "updated_at")
      post api_v1_messages_url, params: { message: new_message }
      expect(JSON.parse(response.body)["id"]).to be(old_message.id + 1)
      expect(response.status).to be(200)
    end
  end
end

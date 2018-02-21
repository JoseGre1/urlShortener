shared_context "a successful request" do
  it "returns an OK (200) status code" do
    expect(response.status).to eq(200)
  end
end

shared_context "a failed create" do
  it "returns an unprocessable entity (422) status code" do
    expect(response.status).to eq(422)
  end
end

shared_context "a response with nested errors" do
  it "returns the error messages" do
    json = JSON.parse(response.body)["errors"]
    expect(json["error"]).to eq(message)
  end
end

shared_context "a response with errors" do
  it "returns the error messages" do
    json = JSON.parse(response.body)
    expect(json["error"]).to eq(message)
  end
end

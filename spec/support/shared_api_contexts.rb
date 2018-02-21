shared_examples_for "all successful endpoints" do
  it "returns an OK (200) status code" do
    expect(response.status).to eq(200)
  end
end

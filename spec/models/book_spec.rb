describe User do
  it "has a valid factory" do
    expect(create(:book)).to be_valid
  end
end

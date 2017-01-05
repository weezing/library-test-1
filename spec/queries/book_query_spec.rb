describe BookQuery do
  it "by default returns books ordered alphabetically" do
    book1 = create(:book, title: "B")
    book2 = create(:book, title: "C")
    book3 = create(:book, title: "A")

    results = BookQuery.new.results
    expect(results.map(&:title)).to eq(["A", "B", "C"])
  end

  it "returns books ordered by another param" do
    book1 = create(:book, year: 1800)
    book2 = create(:book, year: 1900)
    book3 = create(:book, year: 1700)

    results = BookQuery.new(sort_by: "year", sort_direction: "desc").results
    expect(results.map(&:year)).to eq([1900, 1800, 1700])
  end
end

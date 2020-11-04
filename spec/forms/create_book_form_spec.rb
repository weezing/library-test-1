describe CreateBookForm do
  it "valid" do
    params = {
      title: "Title",
      author: "Author",
      year: 2000,
      pages: 200,
      quantity: 2,
      isbn: "111-111"
    }

    form = CreateBookForm.new(params)
    expect(form.valid?).to eq true
  end

  context "invalid" do
    it "title: presence" do
      params = {
        title: "",
        author: "Author",
        year: 2000,
        pages: 200,
        quantity: 2,
        isbn: "111-111"
      }
      form = CreateBookForm.new(params)

      expect(form.valid?).to eq false
      expect(form.errors[:title]).to include("can't be blank")
    end

    it "author: presence" do
      params = {
        title: "Title",
        author: "",
        year: 2000,
        pages: 200,
        quantity: 2,
        isbn: "111-111"
      }
      form = CreateBookForm.new(params)

      expect(form.valid?).to eq false
      expect(form.errors[:author]).to include("can't be blank")
    end

    it "year: presence" do
      params = {
        title: "Title",
        author: "Author",
        year: "",
        pages: 200,
        quantity: 2,
        isbn: "111-111"
      }
      form = CreateBookForm.new(params)

      expect(form.valid?).to eq false
      expect(form.errors[:year]).to include("can't be blank")
    end

    it "year: numericality" do
      params = {
        title: "Title",
        author: "Author",
        year: "abc",
        pages: 200,
        quantity: 2,
        isbn: "111-111"
      }
      form = CreateBookForm.new(params)

      expect(form.valid?).to eq false
      expect(form.errors[:year]).to include("is not a number")
    end

    it "year: too early" do
      params = {
        title: "Title",
        author: "Author",
        year: 1449,
        pages: 200,
        quantity: 2,
        isbn: "111-111"
      }
      form = CreateBookForm.new(params)

      expect(form.valid?).to eq false
      expect(form.errors[:year]).to include("must be greater than or equal to 1450")
    end

    it "year: too late" do
      params = {
        title: "Title",
        author: "Author",
        year: Time.zone.now.year + 1,
        pages: 200,
        quantity: 2,
        isbn: "111-111"
      }
      form = CreateBookForm.new(params)

      expect(form.valid?).to eq false
      expect(form.errors[:year]).to include("must be less than or equal to #{Time.zone.now.year}")
    end

    it "pages: presence" do
      params = {
        title: "Title",
        author: "Author",
        year: 2000,
        pages: "",
        quantity: 2,
        isbn: "111-111"
      }
      form = CreateBookForm.new(params)

      expect(form.valid?).to eq false
      expect(form.errors[:pages]).to include("can't be blank")
    end

    it "pages: numericality" do
      params = {
        title: "Title",
        author: "Author",
        year: 2000,
        pages: "abc",
        quantity: 2,
        isbn: "111-111"
      }
      form = CreateBookForm.new(params)

      expect(form.valid?).to eq false
      expect(form.errors[:pages]).to include("is not a number")
    end

    it "pages: lower than 1" do
      params = {
        title: "Title",
        author: "Author",
        year: 2000,
        pages: 0,
        quantity: 2,
        isbn: "111-111"
      }
      form = CreateBookForm.new(params)

      expect(form.valid?).to eq false
      expect(form.errors[:pages]).to include("must be greater than or equal to 1")
    end

    it "quantity: presence" do
      params = {
        title: "Title",
        author: "Author",
        year: 2000,
        pages: 200,
        quantity: "",
        isbn: "111-111"
      }
      form = CreateBookForm.new(params)

      expect(form.valid?).to eq false
      expect(form.errors[:quantity]).to include("can't be blank")
    end

    it "quantity: numericality" do
      params = {
        title: "Title",
        author: "Author",
        year: 2000,
        pages: 200,
        quantity: "abc",
        isbn: "111-111"
      }
      form = CreateBookForm.new(params)

      expect(form.valid?).to eq false
      expect(form.errors[:quantity]).to include("is not a number")
    end

    it "quantity: lower than 0" do
      params = {
        title: "Title",
        author: "Author",
        year: 2000,
        pages: 200,
        quantity: -1,
        isbn: "111-111"
      }
      form = CreateBookForm.new(params)

      expect(form.valid?).to eq false
      expect(form.errors[:quantity]).to include("must be greater than or equal to 0")
    end

    it "isbn: presence" do
      params = {
        title: "Title",
        author: "Author",
        year: 2000,
        pages: 200,
        quantity: 2,
        isbn: ""
      }
      form = CreateBookForm.new(params)

      expect(form.valid?).to eq false
      expect(form.errors[:isbn]).to include("can't be blank")
    end

    it "isbn: uniqueness" do
      create(:book, isbn: "111-111")
      params = {
        title: "Title",
        author: "Author",
        year: 2000,
        pages: 200,
        quantity: 2,
        isbn: "111-111"
      }
      form = CreateBookForm.new(params)

      expect(form.valid?).to eq false
      expect(form.errors[:isbn]).to include("has already been taken")
    end
  end
end

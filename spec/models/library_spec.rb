require 'rails_helper'
RSpec.describe Library, type: :model do
  describe 'relationships' do
    it { should have_many(:books) }
  end
  before :each do
    @library = Library.create!(name: "Library 1")

    @book_1 = Book.create!(library_id: @library.id, title: "Book Title 1", author: "Book Author 1", status: "available", current_user: "Library")
    @book_2 = Book.create!(library_id: @library.id, title: "Book Title 2", author: "Book Author 2", status: "checked out", current_user: "222222")
    @book_3 = Book.create!(library_id: @library.id, title: "Book Title 3", author: "Book Author 3", status: "checked out", current_user: "333333")
  end

  describe 'instance methods' do
    it 'can return all its books sorted by asc title' do
      expect(@library.books_asc.first).to eq(@book_1)
      expect(@library.books_asc.last).to eq(@book_3)
    end

    it 'can return all its books that are available' do
      expect(@library.available.length).to eq(1)
      expect(@library.available.first).to eq(@book_1)
    end

    it 'can return all its books that are checked out' do
      expect(@library.checked_out.length).to eq(2)
      expect(@library.checked_out.first).to eq(@book_2)
      expect(@library.checked_out.last).to eq(@book_3)
    end

    it 'can return books that match a user' do
      expect(@library.books_by_user("222222").length).to eq(1)
      expect(@library.books_by_user("222222").first).to eq(@book_2)
    end
  end
end

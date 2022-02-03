class Library < ApplicationRecord
  has_many :books

  def books_asc
    self.books.order(:title)
  end

  def books_by_user(user)
    self.books.where(current_user: user).order(:title)
  end

  def available
    self.books.where(status: 'available').order(:title)
  end

  def checked_out
    self.books.where(status: 'checked out').order(:title)
  end
end

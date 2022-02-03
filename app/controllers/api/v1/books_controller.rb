class Api::V1::BooksController < ApplicationController
  def index
    library = Library.find(params[:library_id])
    if params[:status].present?
      if params[:status] == "available"
        books = library.available
        render json: BookSerializer.new(books), status: :ok
      elsif params[:status] == "checkedout"
        books = library.checked_out
        render json: BookSerializer.new(books), status: :ok
      else
        render_bad_request("Incorrect search parameters. Try available or checkedout for status.")
      end
    elsif params[:current_user].present?
      books = library.books_by_user(params[:current_user])
      if books.empty?
        render_bad_request("This user has not checked out any books from this library.")
      else
        render json: BookSerializer.new(books), status: :ok
      end
    else
      books = library.books_asc
      render json: BookSerializer.new(books), status: :ok
    end
  end
end

require 'rails_helper'

RSpec.describe "GET /api/v1/libraries/:id/books" do
  before :each do
    @library_1 = Library.create!(name: "Library 1")
    @library_2 = Library.create!(name: "Library 2")

    @book_1 = Book.create!(library_id: @library_1.id, title: "Book Title 1", author: "Book Author 1", status: "available", current_user: "Library")
    @book_2 = Book.create!(library_id: @library_1.id, title: "Book Title 2", author: "Book Author 2", status: "checked out", current_user: "222222")
    @book_3 = Book.create!(library_id: @library_1.id, title: "Book Title 3", author: "Book Author 3", status: "checked out", current_user: "333333")
    @book_4 = Book.create!(library_id: @library_2.id, title: "Book Title 4", author: "Book Author 4", status: "available", current_user: "Library")
    @book_5 = Book.create!(library_id: @library_2.id, title: "Book Title 5", author: "Book Author 5", status: "checked out", current_user: "555555")
  end

  it 'returns a 200 status when request is made with no query params' do
    get "/api/v1/libraries/#{@library_1.id}/books"

    expect(response.status).to eq(200)
  end

  it 'returns jsonified book objects with all expected attributes in asc order by title' do
    get "/api/v1/libraries/#{@library_1.id}/books"

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:data]).to be_an(Array)
    expect(parsed[:data].first[:attributes][:library_id]).to eq(@library_1.id)
    expect(parsed[:data].first[:id]).to eq("#{@book_1.id}")
    expect(parsed[:data].first[:attributes][:author]).to eq(@book_1.author)
    expect(parsed[:data].first[:attributes][:title]).to eq(@book_1.title)
    expect(parsed[:data].first[:attributes][:status]).to eq(@book_1.status)
    expect(parsed[:data].first[:attributes][:current_user]).to eq(@book_1.current_user)
    expect(parsed[:data][1][:attributes][:title]).to eq(@book_2.title)

  end

  it 'returns a list of books associated with the corresponding libary only' do
    get "/api/v1/libraries/#{@library_1.id}/books"

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:data].length).to eq(3)
    expect(parsed[:data][0][:attributes][:title]).to eq(@book_1.title)
    expect(parsed[:data][1][:attributes][:title]).to eq(@book_2.title)
    expect(parsed[:data][-1][:attributes][:title]).to eq(@book_3.title)
  end

  it 'has optional params for status and will return only the checked in books when status=checkedin' do
    get "/api/v1/libraries/#{@library_1.id}/books?status=available"

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:data].length).to eq(1)
    expect(parsed[:data].first[:attributes][:title]).to eq(@book_1.title)
  end

  it 'will return only the checked out books when status=checkedout' do
    get "/api/v1/libraries/#{@library_1.id}/books?status=checkedout"

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:data].length).to eq(2)
    expect(parsed[:data].first[:attributes][:title]).to eq(@book_2.title)
    expect(parsed[:data].last[:attributes][:title]).to eq(@book_3.title)
  end

  it 'renders a bad request with 400 status if optional params are incorrectly input for status' do
    get "/api/v1/libraries/#{@library_1.id}/books?status=blah"

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:error]).to eq("Incorrect search parameters. Try available or checkedout for status.")
  end

  it 'can return only the books held by a specific user with the optional query current_user=?' do
    get "/api/v1/libraries/#{@library_1.id}/books?current_user=333333"

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:data].length).to eq(1)
    expect(parsed[:data].first[:attributes][:title]).to eq(@book_3.title)
  end

  it 'returns a 400 status and error message if the user in optional param does not have any matching books' do
    get "/api/v1/libraries/#{@library_1.id}/books?current_user=666666"

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:error]).to eq("This user has not checked out any books from this library.")
  end
end

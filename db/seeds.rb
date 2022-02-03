# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@library_1 = Library.create!(name: "Library 1")
@library_2 = Library.create!(name: "Library 2")

@book_1 = Book.create!(library_id: @library_1.id, title: "Book Title 1", author: "Book Author 1", status: "available", current_user: "Library")
@book_2 = Book.create!(library_id: @library_1.id, title: "Book Title 2", author: "Book Author 2", status: "checked out", current_user: "222222")
@book_3 = Book.create!(library_id: @library_1.id, title: "Book Title 3", author: "Book Author 3", status: "checked out", current_user: "333333")
@book_4 = Book.create!(library_id: @library_2.id, title: "Book Title 4", author: "Book Author 4", status: "available", current_user: "Library")
@book_5 = Book.create!(library_id: @library_2.id, title: "Book Title 5", author: "Book Author 5", status: "checked out", current_user: "555555")

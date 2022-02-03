class BookSerializer
  include JSONAPI::Serializer

  attributes :library_id, :title, :author, :status, :current_user
end

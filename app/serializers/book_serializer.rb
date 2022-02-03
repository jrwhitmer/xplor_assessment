class BookSerializer
  include JSONAPI::Serializer

  attributes :id, :library_id, :title, :author, :status, :current_user
end

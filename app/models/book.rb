class Book < ApplicationRecord
  validates :status, inclusion: { in: ["available", "checked out"],
    message: "is not a valid option. Statuses include available and checked out." }
  validates :current_user, presence: true
  belongs_to :library

end

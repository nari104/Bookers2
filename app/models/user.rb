class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy

  has_one_attached :book

  def get_book(width, height)
    unless book.attached?
      file_path = Rails.root.join('app/assets/images/sample-authour1.jpg')
      book.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    book.variant(resize_to_limit: [width, height]).processed
  end
end

class User < ApplicationRecord
  has_many :authored_questions, class_name: 'Question', foreign_key: 'author_id', dependent: :nullify
  has_many :authored_answers, class_name: 'Answer', foreign_key: 'author_id', dependent: :nullify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  def author?(resource)
    resource.author_id == id
  end

end

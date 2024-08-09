# frozen_string_literal: true

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Allowlist

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :argon2,
         :jwt_authenticatable, jwt_revocation_strategy: self

  validates :name, presence: true

  enum role: { member: 0, librarian: 1 }, _default: 0

  has_many :borrows, dependent: :restrict_with_error
  has_many :books, through: :borrows
end

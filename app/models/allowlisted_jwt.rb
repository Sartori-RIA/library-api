# frozen_string_literal: true

class AllowlistedJwt < ApplicationRecord
  belongs_to :user, optional: false
end

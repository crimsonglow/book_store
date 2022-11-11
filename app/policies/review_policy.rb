class ReviewPolicy < ApplicationPolicy
  attr_reader :user, :record

  def create?
    user.present?
  end
end

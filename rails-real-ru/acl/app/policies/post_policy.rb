# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  # BEGIN
  def index?
    true
  end

  def show?
    true
  end

  def new?
    create?
  end

  def create?
    user.present?
  end

  def edit?
    update?
  end

  def update?
    user.present? && (user.admin? || record.author.id == user.id)
  end

  def destroy?
    user.present? && user.admin?
  end
  # END
end

class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.present? 
  end

  def destroy?
    update? && (record.user == user || user.admin?)
  end
  
end
class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    if record.private?
      user.present? && (record.user == user || user.admin?)
    else
      true
    end
  end

  def edit?
    show?
  end

  def update?
    show?
  end
  
  def create?
    user.present? 
  end

  def destroy?
    update? && (record.user == user || user.admin?)
  end
  
end
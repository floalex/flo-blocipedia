class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    if record.private?
      user.present? && (record.user == user || user.admin? || record.collaborate_users.include?(user))
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

  class Scope
     attr_reader :user, :scope
 
     def initialize(user, scope)
       @user = user
       @scope = scope
     end
 
     def resolve
       wikis = []
       if user.role == 'admin'
         wikis = scope.all # if the user is an admin, show them all the wikis
       elsif user.role == 'premium'
         all_wikis = scope.all
         all_wikis.each do |wiki|
           if wiki.public || wiki.user == user || wiki.collaborate_users.include?(user)
             wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
           end
         end
       else # this is the lowly standard user
         all_wikis = scope.all
         wikis = []
         all_wikis.each do |wiki|
           if wiki.public || wiki.collaborate_users.include?(user)
             wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
           end
         end
       end
       wikis # return the wikis array we've built up
     end
   end
  
end
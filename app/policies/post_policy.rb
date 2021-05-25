class PostPolicy < ApplicationPolicy
    def index?
        true
    end
    
    def show?
        true
    end

    def update?
        author?
    end

    def destroy?
        author?
    end

    def create?
        true
    end
    private 
    def author?
        return false unless user
        record.author_id == user.id
    end
end
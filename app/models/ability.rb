class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #

    user ||= User.new # guest user (not logged in)
    if user.has_role? :super_admin # rolify
      can :manage, :all
      #can :access, :ckeditor
      # Performed checks for actions:
      #can [:read, :create, :destroy], Ckeditor::Picture
      #can [:read, :create, :destroy], Ckeditor::AttachmentFile
    else
      # see https://github.com/gregbell/active_admin/blob/master/docs/13-authorization-adapter.md#using-the-cancan-adapter
      cannot :manage, ActiveAdmin::Page
    end

    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end

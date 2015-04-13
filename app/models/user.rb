class User < ActiveRecord::Base

  has_and_belongs_to_many :roles

  after_create :assign_member_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def role?(role)
    !!self.roles.find_by_name(role.to_s.camelize)
  end

  def is_admin?
    self.role?(:super_admin)
  end

  private
  def assign_member_role
    RolesUsers.create!(role_id: Role::USER_ROLE[:member], user_id: self.id)
  end
end

class User < ActiveRecord::Base
  after_create :assign_member_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  rolify

  def is_admin?
    self.email && ADMIN_EMAIL.to_s.include?(self.email)
  end

  private
  def assign_member_role
    self.add_role :member
  end
end

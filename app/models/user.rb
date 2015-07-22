class User < ActiveRecord::Base

  has_and_belongs_to_many :roles

  after_create :assign_member_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  def role?(role)
    !!self.roles.find_by_name(role.to_s.camelize)
  end

  def is_admin?
    self.role?(:super_admin)
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    provider = access_token.provider
    uid = access_token.uid

    user = User.where(:provider => provider, :uid => uid).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user

      user                          = self.new
      user.first_name               = data['first_name']
      user.last_name                = data['last_name']
      user.email                    = data['email']
      user.provider                 = provider
      user.uid                      = uid
      user.password                 = Devise.friendly_token[0,20]

      user.save(validate: true)
    end
    user
  end

  def self.create_from_omniauth_facebook(auth)
    user                          = self.new
    user.first_name               = auth['info']['name'].split(' ').first
    user.last_name                = auth['info']['name'].split(' ').last
    user.provider                 = auth['provider']
    user.uid                      = auth['uid']
    user.password                 = Devise.friendly_token[0,20]

    user.save(validate: true)
    user
  end

  private
  def assign_member_role
    RolesUsers.create!(role_id: Role::USER_ROLE[:member], user_id: self.id)
  end
end

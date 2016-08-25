class User < ActiveRecord::Base
	has_many :members, :dependent => :destroy
	has_many :orgs, :through => :members

	validates :name_first, :presence => { :message => "First name can't be blank" }
	validates :name_last, :presence => { :message => "Last name can't be blank" }

	email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
	validates :email, :format => { :with => email_regex, :message => "Email isn't valid" }
	validates :email, :uniqueness => { :case_sensitive => false, :message => "Email address is already registered" }

	validates :password, :length => { :minimum => 8 }, :on => :create
	has_secure_password

	before_save do
		self.email.downcase!
	end

	def full_name
		self.name_first + " " + self.name_last
	end

end

class Org < ActiveRecord::Base
	belongs_to :owner, :class_name => :User
	has_many :members, :dependent => :destroy
	has_many :users, :through => :members

	validates :name, :length => { :minimum => 6 }
	validates :description, :length => { :minimum => 11 }
end

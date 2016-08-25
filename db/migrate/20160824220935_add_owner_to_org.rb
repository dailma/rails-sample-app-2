class AddOwnerToOrg < ActiveRecord::Migration
	def change
		change_table :orgs do |t|
			t.references :owner, index: true
		end
		add_foreign_key :orgs, :users, :column => :owner_id
	end
end

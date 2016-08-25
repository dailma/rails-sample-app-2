Rails.application.routes.draw do
	root	"users#new"
	
	get		"main"			=> "users#new"
	get		"register"		=> "users#new"
	get		"login"			=> "users#new"
	post	"users"			=> "users#create"
	
	post	"sessions"		=> "sessions#create"
	delete	"sessions"		=> "sessions#destroy"
	get		"logout"		=> "sessions#destroy"
	get		"groups/logout"	=> "sessions#destroy"
	
	get		"groups"		=> "orgs#index"
	get		"groups/:id"	=> "orgs#show"
	post	"groups"		=> "orgs#create", :as => "orgs"
	delete	"groups/:id"	=> "orgs#destroy"

	post	"members"		=> "members#create"
	delete	"members/:id"	=> "members#destroy"
end

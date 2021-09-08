Rails.application.routes.draw do
  root 'login#index'

  # get "/auth/microsoft_office365/callback", to: 'login#create'
  get "/auth/microsoft_graph/callback", to: 'login#create'
  get "/auth/failure", to: 'login#bad'
  delete "/logout", to: "login#destroy"

  resources 'reports', only: [:index, :show, :new]
  resources 'sections', only: [:show]
  get "/parts/:id/final", to: "parts#final_edit", as: "final_edit"
  get "/parts/:id/first", to: "parts#first_edit", as: "first_edit"
  put "/parts/:id/final", to: "parts#final_update"
  put "/parts/:id/first", to: "parts#first_update"
end

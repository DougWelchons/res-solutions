Rails.application.routes.draw do
  root 'login#index'

  resources 'reports', only: [:index, :show, :new]
  resources 'sections', only: [:show]
end

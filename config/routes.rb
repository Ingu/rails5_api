Rails.application.routes.draw do
  resources :companies do
    resources :employees, controller: 'company_employees'
  end
  resources :employees
end

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # match "/admin/:model_name/import" => "custom_admin#import" , :as => "import", :via => [:get, :post]
  
  match "/importer/students" => "importer#students" , :as => "importer_students", :via => [:get, :post]

  resources :page, only: :show
  resources :period_types
  resources :academic_processes, :enroll_academic_processes, :academic_records, :periods, :profiles, :sections, :courses

  resources :students do
    resources :locations
  end

  resources :banks do
    resources :payment_reports
  end
  
  resources :faculties do
    resources :schools do
      resources :admission_types, :grades, :study_plans
      resources :areas do
        resources :subjects
      end
    end
  end

    resources :downloader do
      member do
        get 'section_list'
      end
    end

  devise_for :users
  root to: "pages#home"
  get 'pages/multirols', to: 'pages#multirols'

  get 'teacher_session/dashboard', to: 'teacher_session#dashboard'
  get 'student_session/dashboard', to: 'student_session#dashboard'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

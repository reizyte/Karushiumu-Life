Rails.application.routes.draw do

  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}


  scope module: :public do
    root :to =>"homes#top"
    get "homes/about" => "homes#about", as: "about"
    # customers/editのようにするとdeviseのルーティングとかぶってしまうためinformationを付け加えています。
    #get "customers/information/edit" => "customers#edit", as: "edit_information"
    # patch "customers/information" => "customers#update", as: "update_information"
    get "customers/:id/unsubscribe" => "customers#unsubscribe", as: "confirm_unsubscribe"
    patch "customers/:id/withdraw" => "customers#withdraw", as: "withdraw_customer"

    resources :customers, only:[:show, :edit, :update] do
      member do
        get :favorites
      end
    end


      get "recipes/search" => "recipes#search"


    resources :recipes, only:[:new, :index, :show, :create, :destroy] do
        resource :favorites, only:[:create, :destroy]
        resources :recipe_comments, only:[:create, :destroy]
    end
  end

  #ゲストログイン用
  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'customers/sessions#guest_sign_in'
  end

  namespace :admin do
    root :to => "homes#top"
    resources :genres, only:[:index, :edit, :create, :update]
    resources :customers, only:[:show, :edit, :update]
  end




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

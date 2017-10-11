Rails.application.routes.draw do
  resources :controllers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # root to: "teacher#list"

  # teacher controller
  get 'teacher/list'
  get 'teacher/new'
  post 'teacher/create'
  patch 'teacher/update'
  get 'teacher/show'
  get 'teacher/edit'
  post 'teacher/edit'
  get 'teacher/delete'
  get 'teacher/update'
  get 'teacher/home'
  get 'teacher/logout'
  get 'teacher/crops'


  # login controller
  get 'login/login'
  get 'login/logout'
  get 'login/signup'
  post 'login/send_signup'
  post 'login/check_login'

  #crop controller
  get 'crops/index'
  get 'crops/edit'
  get 'crops/new'
  get 'crops/show'
  get 'crops/logout'
  post 'crops/new'
  get 'crops/create'
  post 'crops/create'
  patch 'crops/update'
  get 'crops/update'
  get 'crops/delete'
  get 'crops/add_tutorial'
  post 'crops/add_tutorial'
  get 'crops/update_tutorial'
  patch 'crops/update_tutorial'

  #message controller
  get 'message/index'
  post 'message/index'
  get 'message/destroy'  
  post 'message/destory'
  post 'message/show'
  get 'message/show'


  # response controller
  get 'response/create'  
  post 'response/create'
  patch 'response/update'

  # android
  post 'android/get_file'
  post 'android/login'
  post 'android/update'
  post 'android/send_message'
  post 'android/update_messages'


  # admin page
  get 'admin/index'
  post 'admin/check_login'


  # institute
  get 'institute/new'
  post 'institute/new'
  get 'institute/create'
  post 'institute/create'
  get 'institute/index'
  post 'institute/index'
  # delete 'institute/destroy'
  get 'institute/destroy'

  
  root to: "login#login"
  resource :teacher 
end

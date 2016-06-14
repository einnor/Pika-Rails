# @Author: Ronnie Nyaga <Ronnie>
# @Date:   2016-06-11T20:28:57+03:00
# @Email:  ronnienyaga@gmail.com
# @Last modified by:   Ronnie
# @Last modified time: 2016-06-13T16:59:19+03:00



Rails.application.routes.draw do
  devise_for :users
  resources :recipes do
    get :autocomplete_l_ingredient_name, :on => :collection
    get :autocomplete_serving_type_name, :on => :collection
  end

  root 'recipes#index'
end

ActionController::Routing::Routes.draw do |map|
  map.resources :dogs

  map.resources :dogs
  map.root :controller => 'dogs'
end

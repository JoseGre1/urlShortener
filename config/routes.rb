Rails.application.routes.draw do
  root to: "pages#home"
  get "/:id", controller: "api/v1/urls", action: "redirect"
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :urls, only: %i[create show]
    end
  end
  get "*unmatched_route" => redirect("/404.html")
end

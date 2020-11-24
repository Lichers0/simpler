Simpler.application.routes do
  get '/tests/:id', 'tests#show_param_id'
  get '/tests', 'tests#index'
  get '/plain', 'tests#plain'
  post '/tests', 'tests#create'
end

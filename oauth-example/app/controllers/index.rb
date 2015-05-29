get '/' do
  @log_in_url = Google.sign_in_url
  erb :index
end

get '/oauth2callback' do
  p params

  # the user's code, which needs to be exchanged
  # for an
  code = params[:code]

  # usually a unique token that you verify is correct
  state = params[:state]

  if state == "logged_in"
    Google.exchange_token(code)
    redirect '/boom'
  else
    erb :failed
  end
end

get '/boom' do
  erb :boom
end
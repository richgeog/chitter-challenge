ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require_relative '../data_mapper_setup'

class Chitter_Challenge < Sinatra::Base

  # register Sinatra::Flash
  enable :sessions
  set :session_secret, 'super secret'


  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/peeps' do
    @peeps = Peep.all
    erb :'peeps/index'
  end

  get '/peeps/new' do
    erb :'peeps/new'
  end

  post '/peeps' do
    Peep.create(peeps: params[:peep], time: Time.now)
    redirect to('/peeps')
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    user = User.new(email: params[:email],
                password: params[:password],
                password_confirmation: params[:password_confirmation])
    if user.save
      session[:user_id] = user.id
      redirect to('/peeps')
    else
      erb :'users/new'
    end
  end
end

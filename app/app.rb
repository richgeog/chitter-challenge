ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require_relative '../data_mapper_setup'

class Chitter_Challenge < Sinatra::Base

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
end

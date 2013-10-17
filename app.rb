require 'bundler'
Bundler.require
require './idea'

class IdeaBoxApp < Sinatra::Base

  set :method_override, true

  not_found do
    haml :error
  end

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    haml :index, locals: {ideas: Idea.all, idea: Idea.new, mode: "new"}
  end

  get '/:id/edit' do |id|
    idea = Idea.find(id.to_i)
    haml :edit, locals: {id: id, idea: idea, mode: "edit"} 
  end

  put '/:id' do |id|
    Idea.update(id.to_i, params[:idea])
    redirect '/'
  end

  post '/' do
    idea = Idea.new(params[:idea])
    idea.save
    redirect '/'
  end

  delete '/:id' do |id|
    Idea.delete(id.to_i)
    redirect '/'
  end
end

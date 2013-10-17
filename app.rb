require 'bundler'
Bundler.require
require './idea'
require './idea_store'

class IdeaBoxApp < Sinatra::Base

  set :method_override, true

  not_found do
    haml :error
  end

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    haml :index, locals: {ideas: IdeaStore.all, idea: Idea.new, mode: "new"}
  end

  post '/' do
    IdeaStore.create(params[:idea])
    redirect '/'
  end

  put '/:id' do |id|
    IdeaStore.update(id.to_i, params[:idea])
    redirect '/'
  end

  get '/:id/edit' do |id|
    idea = IdeaStore.find(id.to_i)
    haml :edit, locals: {id: id, idea: idea, mode: "edit"} 
  end

  delete '/:id' do |id|
    IdeaStore.delete(id.to_i)
    redirect '/'
  end
end

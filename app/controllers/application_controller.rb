
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do

    redirect to '/articles'

  end

  get '/articles' do #reader method

    @articles = Article.all #save all instances to this variable, so we can call & display w/in index 
    erb :index  #index view where we can see all items

  end

  get '/articles/new' do #create method

    @article = Article.new #save creation of new istance w/in this method

    erb :new #create view

  end 

  post '/articles' do #create method that pushes request & redirects to the instances url page

    @article = Article.create(title: params[:title], content: params[:content])
    redirect to "/articles/#{@article.id}"

  end 

  get '/articles/:id' do #reader method
    
    @article = Article.find(params[:id]) #grab params and save to @article instance method
    erb :show #show view 

  end

  get '/articles/:id/edit' do #update method w/ form

    @article = Article.find(params[:id])
    erb :edit #view for edit #form

  end 

  patch '/articles/:id' do #update method that processes form

    @article = Article.find(params[:id])
    @article.update(params[:article])
    redirect to "/articles/#{@article.id}"

  end

  delete '/articles/:id' do #delete 
  
    Article.delete(params[:id])
    redirect to "/articles"

    end

end

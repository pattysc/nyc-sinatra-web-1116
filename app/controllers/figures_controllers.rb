class FiguresController < ApplicationController

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  post '/figures' do
    @figure = Figure.create(params["figure"])


    if params["title"]["name"] != ''
      @title = Title.create(params["title"])
      @figure.title_ids = @title.id
    end

    if params["landmark"]["name"] != ''
      @landmark = Landmark.create(params["landmark"])
      @figure.landmark_ids = @landmark.id
    end

    @figure.save
  end

  get '/figures' do
    @figures = Figure.all
    "hello"
    erb :'figures/index'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    @titles = @figure.titles
    @landmarks = @figure.landmarks

    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])

    @landmark = Landmark.find(@figure.landmark_ids.first)
    #
    @titles = Title.all
    @landmarks = Landmark.all

    erb :'figures/edit'
  end

  patch '/figures/:id' do

    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])

    if params["title"]["name"] != ''
      @title = Title.create(params["title"])
      @figure.title_ids = @title.id
    end

    if params["landmark"]["name"] != ''
      @landmark = Landmark.create(params["landmark"])
      @figure.landmark_ids = @landmark.id
    end
    @figure.save
    redirect :"/figures/#{@figure.id}"
  end



end

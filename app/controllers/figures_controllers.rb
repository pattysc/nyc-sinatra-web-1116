class FiguresController < ApplicationController

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  post '/figures' do
    # binding.pry
    @figure = Figure.new
    @figure.name = params["figure"]["name"]
    @figure.title_ids = params["figure"]["title_ids"]
    @figure.landmark_ids = params["figure"]["landmark_ids"]

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
    @title = Title.find(@figure.title_ids)
    @landmark = Landmark.find(@figure.landmark_ids.first)

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
    # @figure.name = params["figure"]["name"]
    # @figure.title_ids = params["figure"]["title_ids"]
    # @figure.landmark_ids = params["figure"]["landmark_ids"]
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

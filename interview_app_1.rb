require 'rubygems'
require 'sinatra'
require 'bundler/setup'
require './lib/product'
require './lib/search'
require 'cgi'

Search.configure do |conf|
  conf.base_url = "https://www.googleapis.com/shopping/search/v1/public/products"
  conf.key      = ENV['GOOGLE_API_KEY'] || "YourApiKey"
  conf.country  = "US"
end

get '/' do
  @products = []
  @query = ''
  erb :index
end

get '/search' do
  search_query = [params[:query], "vintage decor"].compact.join(" ")
  @products = Product.find search_query, :rankBy => 'price:ascending'
  @query    = params[:query] || ""
  erb :index
end

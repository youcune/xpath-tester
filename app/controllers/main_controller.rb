require 'rexml/document'

class MainController < ApplicationController
  def index
    if params[:xml].present? && params[:xpath].present?
      @elements = REXML::Document.new(params[:xml]).get_elements(params[:xpath])
    end
  end
end

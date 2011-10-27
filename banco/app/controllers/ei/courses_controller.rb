class Ei::CoursesController < ApplicationController
  def index
    render :xml => File.read(Rails.root.join("xml/ei/cursocontenidos.xml"))
  end
end

class Ei::CoursesController < ApplicationController
  def index
    render :xml => File.read(Rails.root.join("xml/ei/cursocontenidos.xml"))
  end
  
  def show
    Course.xml_for_single_course(params[:id])
  end
end

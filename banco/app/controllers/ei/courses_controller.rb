class Ei::CoursesController < ApplicationController
  def index
    render :xml => Course.xml_for_all_courses
  end
  
  def show
    render :xml => Course.xml_for_single_course(params[:id])
  end
end

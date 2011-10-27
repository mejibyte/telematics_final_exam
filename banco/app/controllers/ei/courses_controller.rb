class Ei::CoursesController < ApplicationController
  def index
    render :xml => Course.xml_for_all_courses(current_teacher)
  end
  
  def show
    render :xml => Course.xml_for_single_course(current_teacher, params[:id])
  end
end

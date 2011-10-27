class Ei::StudentsController < ApplicationController
  def index
    render :xml => Student.xml_for_students_on_course(current_teacher, params[:course_id], params[:group])
  end
end

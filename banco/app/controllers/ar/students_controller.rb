class Ar::StudentsController < ApplicationController
  def search
    render :xml => Student.xml_for_students_with_similar_name(current_teacher, params[:name_pattern])
  end
  
  def show
    render :xml => Student.xml_for_single_student(current_teacher, params[:id])
  end
end

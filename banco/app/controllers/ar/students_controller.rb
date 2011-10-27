class Ar::StudentsController < ApplicationController
  def search
    render :xml => Student.xml_for_students_with_similar_name(current_teacher, params[:name_pattern])
  end
end

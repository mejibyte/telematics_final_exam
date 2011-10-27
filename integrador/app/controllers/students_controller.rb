class StudentsController < ApplicationController
  def search
    @students = Api::Student.search(current_token, params[:name_pattern])
  end
  
  def show
    @student = Api::Student.show(current_token, params[:id])
  end
end

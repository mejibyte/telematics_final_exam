class Pa::SchedulesController < ApplicationController
  def show
    render :xml => Schedule.xml_for_course_schedule(current_teacher, params[:course_id], params[:group], params[:semester])
  end
end

class Teacher::LessonSubmissionPeriodController < Teacher::Base

  def edit
    set_lesson
  end
  def update
    set_lesson
    if @lesson.update(lesson_params)
      flash[:success] = '授業の提出期間を更新しました'
      redirect_to edit_teacher_lesson_submission_period_path(@lesson)
    else
      render :edit
    end
  end

  private
  def set_lesson
    @lesson = current_teacher.lessons.find(params[:id])
    @lesson_group = @lesson.lesson_group
  end

  def lesson_params
    params.require(:lesson).permit(:start_at_date, :start_at_hour,
      :start_at_min, :end_at_date, :end_at_hour, :end_at_min)
  end
end

# TODO: 不要なので、消す予定。2020/11/03
# class Teacher::AnswerChecksController < Teacher::Base
#   before_action :set_variables, :security_check

#   def checking
#     @comment = current_teacher.comments.new(answer_id: @target_answer.id)
#   end

#   def check
#     @comment = current_teacher.comments.new(comment_params)

#     if @comment.save
#       flash[:success] = 'コメントしました。'
#       @comment.answer.question_status.update(status: 'commented')
#       redirect_to checking_teacher_question_status_answer_checks_path(@question_status)
#     else
#         render :checking
#     end
#   end

#   private

#   # TODO: いらないので消すが、コードを一旦残す。
#   # def answer_check_params
#   #   params.require(:teacher_answer_check_form).permit(:text, :evaluation, :answer_id, :image)
#   # end

#   def set_variables
#     @question_status = QuestionStatus.find(params[:question_status_id])
#     @question = @question_status.question
#     @lesson = @question.lesson
#     @user = @question_status.user
#     @answers = @question.answers
#     @target_answer = @answers.last
#   end

#   def security_check
#     return if current_teacher_school.id == @lesson.school_id
#     raise '不正なリクエストです'
#   end

#   def set_page
#     @page = params[:page]&.to_i || 1
#   end

#   def set_lesson
#     @lesson = current_teacher.lessons.find(params[:lesson_id])
#   end

#   def set_question_and_answers
#     @question_statuses = @lesson.question_statuses_to_check
#     @question_status = @question_statuses[@page - 1]
#     @question = @question_status&.question
#     @answers = @question_status&.answers
#   end

#   def comment_params
#     params.require(:comment).permit(:text, :image, :answer_id)
#   end
# end

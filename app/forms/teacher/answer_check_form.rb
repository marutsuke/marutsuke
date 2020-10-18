# TODO: 使ってないので、消す予定だが、コード例として残したい気がして。

class Teacher::AnswerCheckForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  extend CarrierWave::Mount

  mount_uploader :image, ImageUploader

  attribute :text, :string
  attribute :answer_id, :integer
  attribute :image, :string
  validates :text, length: { maximum: 400 }
  validates :answer_id, presence: true
  validate :image_size

  def initialize(teacher, params = {})
    @teacher = teacher
    super(params)
  end

  def save
    return false if invalid?

    question_status.update!(status: 'commented')
    comment.save!

    true
  end

  def question_status
    @question_status ||= Answer.find(answer_id).question_status
  end

  def comment
    @comment ||= @teacher&.comments.new(text: text, image: image, teacher_id: @teacher.id, answer_id: answer_id)
  end

  private
  def image_size
    errors.add(:image, 'サイズは5MBまでです。') if image.size > 5.megabytes
  end
end

require 'rails_helper'

RSpec.describe "Teacher::LessonGroups", type: :request do

  let(:teacher) { create(:teacher) }
  let!(:lesson_group){ create(:lesson_group, school_building: teacher.main_school_building) }
  before { teacher_log_in(teacher) }

  describe '/teacher/lesson_groups#index ' do
    it 'アクセスできる' do
      get teacher_lesson_groups_path
      expect(response).to have_http_status(200)
    end
  end

  describe '/teacher/lesson_groups/:id#show ' do
    it 'アクセスできる' do
      get teacher_lesson_group_path(lesson_group)
      expect(response).to have_http_status(200)
    end
  end

  describe '/teacher/lesson_groups/new#new ' do
    let!(:lesson_groups){ create(:lesson_group) }
    it 'アクセスできる' do
      get new_teacher_lesson_group_path
      expect(response).to have_http_status(200)
    end
  end

  describe '/teacher/lesson_groups#create' do
    let(:lesson_group_params) do
      {
        name: 'テスト講座',
        school_building_id: teacher.main_school_building.id,
        start_at: '2020-02-10',
        school_year: 2020,
        min_school_grade: 20,
        max_school_grade: nil,
      }
    end
    it '講座を作成できる' do
      expect do
        post teacher_lesson_groups_path, params: { lesson_group: lesson_group_params }
      end.to change(LessonGroup, :count).by(1)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_teacher_lesson_group_path
    end
  end

  describe '/teacher/lesson_groups/edit#edit' do
    it 'アクセスできる' do
      get edit_teacher_lesson_group_path(lesson_group)
      expect(response).to have_http_status(200)
    end
  end

  describe '/teacher/lesson_groups/:id#update' do
    let!(:lesson_group){ create(:lesson_group, name: 'テスト講座', school_building: teacher.main_school_building) }
    let(:lesson_group_params) do
      {
        name: 'テスト講座編集',
        school_building_id: teacher.main_school_building.id,
        school_year: 2020,
        min_school_grade: 20,
        max_school_grade: nil,
      }
    end
    it '講座を編集できる' do
      patch teacher_lesson_group_path(lesson_group), params: { lesson_group: lesson_group_params }
      expect(lesson_group.name).to eq('テスト講座')
      expect(lesson_group.reload.name).to eq('テスト講座編集')
      expect(response).to have_http_status(302)
      expect(response).to redirect_to edit_teacher_lesson_group_path(lesson_group)
    end
  end


end

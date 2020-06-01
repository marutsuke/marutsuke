# frozen_string_literal: true

module ActiveHelper
  def footer_active_judge(kind, flag)
    kind == flag ? 'fas' : 'far'
  end

  def lessons_active_judge(kind, flag)
    kind == flag ? 'active' : ''
  end
end

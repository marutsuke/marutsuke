class AddRejectJoinRequestToSchoolBuilding < ActiveRecord::Migration[6.0]
  def change
    add_column :school_buildings, :invite_code_availability, :boolean, after: :auto_invite, null: false, default: true
  end
end

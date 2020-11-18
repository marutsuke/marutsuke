class AddAutoInviteToSchoolBuilding < ActiveRecord::Migration[6.0]
  def change
    add_column :school_buildings, :auto_invite, :boolean, after: :invitation_code, null: false, default: false
  end
end

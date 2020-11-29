class AddInvitationCodeToSchoolBuilding < ActiveRecord::Migration[6.0]
  def change
    add_column :school_buildings, :invitation_code, :string, after: :school_id
    add_index :school_buildings, :invitation_code, unique: true
  end
end

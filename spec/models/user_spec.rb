# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string
#  name       :string
#  auth_token :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Model Validations" do
    it "should have the proper structure" do
      should have_db_column("id")
      should have_db_column("email")
      should have_db_column("name")
      should have_db_column("auth_token")
      should have_db_column("created_at")
      should have_db_column("updated_at")
    end
    it "should have many notes" do
      should have_many("notes")
    end
    it "should have the proper validations" do
      should validate_presence_of("email")
      should validate_presence_of("name")
    end
  end
end

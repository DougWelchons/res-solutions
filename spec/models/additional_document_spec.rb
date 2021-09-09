require 'rails_helper'

RSpec.describe AdditionalDocument, type: :model do
  it { should belong_to(:part) }
  it { should belong_to(:user) }
  it { should have_one(:sub_section).through(:part) }
  it { should have_one(:section).through(:sub_section) }
  it { should have_one(:report).through(:section) }
end

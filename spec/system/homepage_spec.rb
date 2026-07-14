require "spec_helper"

RSpec.describe "Homepage" do
  it "loads and shows the org name and member list" do
    visit "/"

    expect(page).to have_content("Alliance of Civic Technologists")
    expect(page).to have_content("Our Member Organizations")
  end
end

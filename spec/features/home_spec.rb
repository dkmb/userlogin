require 'spec_helper'

describe "Static pages" do

  describe "About page" do
    it "should have the content 'Sample App'" do
      visit '/about'
      expect(page).to have_content('About')
    end    
  end
  
  describe "Contact page" do
    it "should have the content 'Sample App'" do
      visit '/contact'
      expect(page).to have_content('Contact')
    end    
  end
  
end
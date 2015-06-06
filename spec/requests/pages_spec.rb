require 'rails_helper'

descibe 'Pages'  do
  descibe 'About page' do
    it 'should have content Ryte Club' do
      visit '/pages/about'
      expect(page).to have_content('Ryte Club')
    end	
  end
end
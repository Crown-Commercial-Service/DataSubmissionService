require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe 'levy_as_string' do
    it 'returns a pence levy as pounds' do
      expect(helper.levy_as_string(400)).to eq '£4.00'
      expect(helper.levy_as_string(553200)).to eq '£5,532.00'
      expect(helper.levy_as_string(12413555)).to eq '£124,135.55'
    end
  end
end

require 'rails_helper'

RSpec.describe PaginationHelper do
  describe '#page_entries_info' do
    let(:short_list) do
      list = []
      5.times do
        list << API::Customer.new
      end
      list
    end

    let(:long_list) do
      list = []
      25.times do
        list << API::Customer.new
      end
      list
    end

    let(:short_meta) do
      {
        "total": 5,
        "per_page": 25,
        "offset_value": 0,
        "current_page": 1,
        "total_pages": 1
      }
    end

    let(:long_meta) do
      {
        "total": 30,
        "per_page": 25,
        "offset_value": 0,
        "current_page": 1,
        "total_pages": 2
      }
    end

    it 'displays a message about the number of entries on display' do
      expect(helper.page_entries_info(short_list, short_meta,
                                          entry_name: 'customer')).to eq 'Displaying <b>all 5</b> customers'
      expect(helper.page_entries_info(long_list, long_meta,
                                          entry_name: 'customer')).to include '<b>1&nbsp;</b>to<b>&nbsp;25</b> of'
    end
  end
end

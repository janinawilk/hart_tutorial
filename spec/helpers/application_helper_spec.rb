require 'rails_helper'

describe ApplicationHelper do
  describe "#full_title" do
    let(:base_title) { 'I am learing' }

    context 'when page_title empty' do
      let(:page_title) { '' }
      it 'returns the base_title' do
        expect(helper.full_title(page_title)).to eql('I am learning')
      end
    end

    context 'when page_title present' do
      let(:page_title) { 'foo' }
      it 'returns the base_title' do
        expect(helper.full_title(page_title)).to eql('foo | I am learning')
      end
    end
  end
end

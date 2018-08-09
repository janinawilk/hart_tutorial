require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do
    let(:relationship) { create(:relationship)}

  it 'relationship creation not successful when user not logged in' do
    expect { post relationships_path }.not_to change(Relationship, :count)
  end

  it 'relationship deletion not successful when user not logged in' do
    expect { delete relationship_path(:relationship) }.not_to change(Relationship, :count)
  end

end

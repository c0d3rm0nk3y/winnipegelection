require 'spec_helper'

describe Election do
  context 'when an election has electoral races' do
    let(:election) do
      FactoryGirl.create(:election_with_electoral_races,
                         electoral_race_count: ASSOCIATION_COUNT)
    end
    subject { election }
    it      { is_expected.to have(ASSOCIATION_COUNT).electoral_races }
    it      { is_expected.to have(ASSOCIATION_COUNT).regions }
  end

  context 'when an election has a candidacy through an electoral race' do
    let(:election) do
      FactoryGirl.create(:election_with_candidacy_through_electoral_race)
    end
    subject { election }
    it      { is_expected.to have(1).candidacies }
  end
end
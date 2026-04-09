# frozen_string_literal: true

RSpec.describe Eyepiece::QuickSearch do
  it "is an alias for Eyepiece::Search" do
    expect(described_class).to eq Eyepiece::Search
  end
end

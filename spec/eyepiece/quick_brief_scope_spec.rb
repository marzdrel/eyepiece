# frozen_string_literal: true

RSpec.describe Eyepiece::QuickBriefScope do
  it "is an alias for Eyepiece::Brief" do
    expect(described_class).to eq Eyepiece::Brief
  end
end

# frozen_string_literal: true

RSpec.describe Eyepiece::Brief do
  describe ".brief" do
    it "calls reselect with the specified fields" do
      model = Class.new
      model.include described_class.new(:id, :email, :name)
      allow(model).to receive(:reselect)

      model.brief

      expect(model)
        .to have_received(:reselect)
        .with(:id, :email, :name)
    end

    it "uses custom method name when specified" do
      model = Class.new
      model.include described_class.new(:id, :email, method: :summary)
      allow(model).to receive(:reselect)

      model.summary

      expect(model)
        .to have_received(:reselect)
        .with(:id, :email)
    end
  end
end

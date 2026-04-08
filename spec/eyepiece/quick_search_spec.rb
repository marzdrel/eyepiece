# frozen_string_literal: true

RSpec.describe Eyepiece::QuickSearch do
  describe ".like" do
    it "finds matching record when one result exists" do
      model = Class.new
      model.include described_class.new(:firstname, :lastname)
      allow(model).to receive_messages(where: [:result1])
      allow(ActiveRecord::Base)
        .to receive_message_chain(:connection, :quote_column_name) { |name| "\"#{name}\"" }

      expect(model.like("test")).to eq :result1
    end

    it "generates expected query with multiple fields" do
      model = Class.new
      model.include described_class.new(:firstname, :lastname)
      allow(model).to receive_messages(where: [:result1])
      allow(ActiveRecord::Base)
        .to receive_message_chain(:connection, :quote_column_name) { |name| "\"#{name}\"" }

      model.like("test")

      expect(model)
        .to have_received(:where)
        .with(
          "\"firstname\"::text ILIKE :txt1 OR \"lastname\"::text ILIKE :txt1",
          txt1: "%test%",
        )
    end

    it "generates expected query with single field" do
      model = Class.new
      model.include described_class.new(:name)
      allow(model).to receive_messages(where: [:result1])
      allow(ActiveRecord::Base)
        .to receive_message_chain(:connection, :quote_column_name) { |name| "\"#{name}\"" }

      model.like("test")

      expect(model)
        .to have_received(:where)
        .with(
          "\"name\"::text ILIKE :txt1",
          txt1: "%test%",
        )
    end

    it "raises an error when multiple results are found" do
      model = Class.new
      model.include described_class.new(:firstname, :lastname)
      allow(model).to receive_messages(where: %w[result1 result2])
      allow(ActiveRecord::Base)
        .to receive_message_chain(:connection, :quote_column_name) { |name| "\"#{name}\"" }

      expect { model.like("test") }
        .to raise_error Eyepiece::TooManyRecordsError, /\(2\) for "test"/
    end

    it "returns all results when require_one is false" do
      model = Class.new
      model.include described_class.new(:firstname, :lastname)
      allow(model).to receive_messages(where: %w[result1 result2])
      allow(ActiveRecord::Base)
        .to receive_message_chain(:connection, :quote_column_name) { |name| "\"#{name}\"" }

      expect(model.like("test", require_one: false))
        .to eq %w[result1 result2]
    end

    it "handles multiple search terms" do
      model = Class.new
      model.include described_class.new(:name)
      allow(model).to receive_messages(where: [:result1])
      allow(ActiveRecord::Base)
        .to receive_message_chain(:connection, :quote_column_name) { |name| "\"#{name}\"" }

      model.like("foo", "bar")

      expect(model)
        .to have_received(:where)
        .with(
          "\"name\"::text ILIKE :txt1 OR \"name\"::text ILIKE :txt2",
          txt1: "%foo%",
          txt2: "%bar%",
        )
    end
  end

  describe ".mlike" do
    it "returns all matching results" do
      model = Class.new
      model.include described_class.new(:firstname, :lastname)
      allow(model).to receive_messages(where: %w[result1 result2])
      allow(ActiveRecord::Base)
        .to receive_message_chain(:connection, :quote_column_name) { |name| "\"#{name}\"" }

      expect(model.mlike("test")).to eq %w[result1 result2]
    end
  end
end

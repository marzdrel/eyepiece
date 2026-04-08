# frozen_string_literal: true

module Eyepiece
  class QuickSearch < Module
    class Searcher
      def self.call(...)
        new(...).call
      end

      def initialize(*fields, scope:, txt:, require_one:)
        self.scope = scope
        self.fields = fields
        self.txt = Array(txt)
        self.require_one = require_one
      end

      def call
        phrases =
          txt.map.with_index(1).to_h do |phrase, index|
            key = format("txt%<index>d", index: index).to_sym
            [key, "%#{phrase}%"]
          end

        records = scope.where(query, **phrases)

        if require_one
          raise_error(records.length) if records.length > 1
          records.first
        else
          records
        end
      end

      private

      def columns
        fields.map do |field|
          ActiveRecord::Base.connection.quote_column_name(field)
        end
      end

      def query
        queries =
          txt.flat_map.with_index(1) do |_, index|
            columns.map do |field|
              "#{field}::text ILIKE :txt#{index}"
            end
          end

        queries.join(" OR ")
      end

      def raise_error(count)
        raise(
          ArgumentError,
          format(
            "too many records (%<count>d) for \"%<query>s\"",
            count: count,
            query: txt.join(", "),
          ),
        )
      end

      attr_accessor :fields, :scope, :txt, :require_one
    end

    def included(base)
      base.send(:extend, @module)
    end

    def initialize(*fields)
      @module = Module.new do
        define_method :like do |*txt, require_one: true|
          Searcher.call(*fields, scope: self, txt: txt, require_one: require_one)
        end

        define_method :mlike do |*txt, require_one: false|
          Searcher.call(*fields, scope: self, txt: txt, require_one: require_one)
        end
      end
    end
  end
end

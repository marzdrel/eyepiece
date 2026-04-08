# frozen_string_literal: true

module Eyepiece
  class QuickBriefScope < Module
    def initialize(*fields, method: :brief)
      @module = Module.new do
        define_method method do
          reselect(*fields)
        end
      end
    end

    def included(base)
      base.send(:extend, @module)
    end
  end
end

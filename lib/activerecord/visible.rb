# encoding: utf-8
require 'active_support/concern'

module Activerecord
  module Visible
    extend ActiveSupport::Concern

    included do
      class_attribute :visible_attributes
      self.visible_attributes = Hash.new { |hash, key| hash[key] = [] }
    end

    module ClassMethods
      def attr_visible(*args)
        options = args.extract_options!
        Array.wrap(options[:as]).each do |name|
          self.visible_attributes[name] += args
        end
      end
    end
  end
end

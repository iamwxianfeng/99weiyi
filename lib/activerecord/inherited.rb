# encoding: utf-8
require 'active_support/concern'

module Activerecord
  module Inherited
    extend ActiveSupport::Concern

    module ClassMethods
      def inherited(subclass)
        super
        subclass.visible_attributes = visible_attributes.dup
      end
    end
  end
end

# encoding: utf-8
#
# Copyright (C) 2011-2014  99weiyi, Inc.

module Weiyi

  module Mapper

    def post hash
      save_with_hash hash, :post
    end

    def patch hash
      save_with_hash hash, :patch
    end

    def save_with_hash hash, method
      assign_attributes hash, :as => method
      raise ValidatesError.new(class_name, errors.messages) if invalid?
      save
      self
    end

    def to_hash role = :default
      hash = as_json(only: self.class.visible_attributes[role])
      return hash if frozen?
      hash
    end

    def class_name
      @class_name ||= self.class.to_s.split("::").last
    end

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def post hash
        self.new.post hash
      end

      def get id, *args, &block
        validate_id id
        find(id) or raise MissingError.new(self.to_s.split("::").last.downcase.to_sym)
      end
    end

  end
end

# encoding: utf-8
#
# Copyright (C) 2011-2014  AdMaster, Inc.

module Chimaapi

  module Error
    def self.t key, options = {}
      I18n.t(key.to_sym, {scope: 'errors.messages'}.merge(options))
    end
  end

  # # fields 合法性验证  主要用于表单验证
  # class ValidatesError < StandardError
  #   attr_reader :errors

  #   def initialize(resource = nil, errors = [])
  #     prefix = ''
  #     key = resource.to_s
  #     if key.include? '.'
  #       index = key.index('.')
  #       prefix = key[index + 1, key.length] + '.'
  #     end
  #     @errors = errors.map do |k, v|
  #       { field: "#{prefix}#{k}", error_code: :invalid, error: v.join(', ') }
  #     end

  #     message = Error.t :validation_failed
  #     super(message)
  #   end
  # end

  class BaseError < StandardError
    attr_reader :error_code, :resource, :field

    def initialize(message = '', error_code = :invalid, resource = nil, field = nil)
      @error_code = error_code.to_sym
      @resource   = resource
      @field      = field
      super(message)
    end
  end

  # 一般错误信息
  class NormalError < BaseError
    def initialize(message = nil, error_code = :invalid)
      message = Error.t(message || :invalid)
      super(message)
    end
  end

  class MissingError < BaseError
    def initialize(resource = nil, message = nil)
      message = Error.t(message || :missing, resource: resource)
      super(message, :missing, resource)
    end
  end

  class MissingFieldError < BaseError
    def initialize(resource = nil, field = nil, message = nil)
      message = Error.t(message || :missing_field, field: field)
      super(message, :missing_field, resource, field)
    end
  end

  class InvalidFieldError < BaseError
    def initialize(resource = nil, field = nil, message = nil)
      message = Error.t(message || :invalid_field, field: field)
      super(message, :invalid_field, resource, field)
    end
  end

  # class RequestError < BaseError
  #   def initialize(resource = nil, field = nil)
  #     super("Problems parsing JSON.", :parse_error, resource, field)
  #   end
  # end

  class UnauthorizedError < BaseError
    def initialize(resource = nil, field = nil, message = nil)
      message = Error.t message || :unauthorized
      super(message, :unauthorized, resource, field)
    end
  end

  class PermissionDeniedError < BaseError
    def initialize(resource = nil, field = nil, message = nil)
      message = Error.t(message || :permission_denied, resource: resource)
      super(message, :permission_denied, resource, field)
    end
  end

  class OauthError < BaseError
    def initialize(message)
      super(message, :oauth_error)
    end
  end

  class ExceedLimitError < BaseError
    def initialize(message = nil, limit = 0, resource = nil, field = nil)
      message = Error.t(message || :exceed_limit, limit: limit)
      super(message, :exceed_limit, resource, field)
    end
  end


  class ResponseError < BaseError
    def initialize(message)
      super(message, :respones_error)
    end
  end

end

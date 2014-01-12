# encoding: utf-8
module Chimaapi

  class ErrorsController < ApplicationController

    ERROR_TYPES = [Chimaapi::ValidatesError, Chima::BaseError]

    superclass.error ERROR_TYPES do
      ex = env['sinatra.error']
      response = {:message => ex.message}
      if ex.respond_to? :errors
        errors = ex.errors
      else
        errors = []
        error = {}
        fields = [:resource, :error_code, :field, :question_id]
        fields.each do |field|
          error[field] = ex.send(field) if ex.respond_to? field
        end
        unless error.empty?
          error[:error] = ex.message
          errors << error
        end
      end
      response[:errors] = errors

      http_status = 422
      status_codes = {
        400 => Chimaapi::RequestError,
        401 => Chimaapi::UnauthorizedError,
        403 => Chimaapi::PermissionDeniedError,
        410 => Chimaapi::MissingError,
      }
      status_codes.each do |key, val|
        if ex.is_a? val
          http_status = key
          break
        end
      end
      status http_status
      json response
    end

    superclass.error do
      ex = env['sinatra.error']
      unless ERROR_TYPES.include?(ex.class)
        File.open("#{Rails.root}/tmp/weiyi.stderr.log", "a+") do |file|
          file.puts(ex.backtrace.unshift(ex.message).push("\n\n\n"))
        end
      end
    end

  end
end

#encoding: utf-8

class Api::HomeController < ApplicationController
	def step1
		render :json=> {ticket: 2}
	end
end
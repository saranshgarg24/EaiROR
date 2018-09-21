class NumbersController < ApplicationController

  before_action :verify_number_format
  before_action :set_page

  def create
    number = PhoneNumber.generate_number @number
    render status: :ok, json: {
      message: "success",
      phone_number: number.number
    }
  end

  def index
    numbers = PhoneNumber.page(@page)
    render status: :ok, json: {
      message: "success",
      numbers: numbers.as_json(only: [:id, :number])
    }
  end

  private

  def set_page
    @page = params[:page].to_i
    @page = 1 unless (@page.is_a?(Integer) && @page > 0)
  end

  def verify_number_format
    @number = params[:number]
    if @number.present?
      if @number.length == 10
        first_part = @number[0..2].to_i
        second_part = @number[3..5].to_i
        third_part = @number[6..9].to_i
        if third_part < 1111 || second_part < 111 || first_part < 111
          @number = nil
        end
      else
        @number = nil
      end
    end
  end

end

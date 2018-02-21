module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :four_hundred_four
    rescue_from ActiveRecord::RecordInvalid, with: :four_hundred_twenty_two
  end

  private

  def four_hundred_four
    redirect_to "/404.html"
  end

  def four_hundred_twenty_two(e)
    render json: { message: e.message}, status: :unprocessable_entity
  end
end

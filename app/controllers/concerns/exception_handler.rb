module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :four_hundred_four
  end

  private

  def four_hundred_four
    redirect_to "/404.html"
  end
end

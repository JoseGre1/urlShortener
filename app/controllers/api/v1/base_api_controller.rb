class Api::V1::BaseApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_base_url

  def set_base_url
    @base_url = request.url.split("api")[0]
  end
end

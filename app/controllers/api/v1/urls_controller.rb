class Api::V1::UrlsController < Api::V1::BaseApiController
  def create
    @url = Url.new(url_params)
    unless @url.save!
      json_response(@url&.errors&.messages || {}, :unprocessable_entity)
    end
  end

  def show
    @url = Url.find(params[:id])
  end

  def redirect
    @url = Url.friendly.find(params[:id])
    redirect_to @url.original
  end

  private

  def url_params
    params.require(:url).permit(:original)
  end
end

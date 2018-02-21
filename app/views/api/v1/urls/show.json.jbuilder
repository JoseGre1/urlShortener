json.extract! @url, :id, :original
json.shortened_url "#{@base_url}#{@url.code}"

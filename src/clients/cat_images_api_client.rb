class CatImagesApiClient
  include HTTParty

  base_uri 'api.thecatapi.com'

  def cat_image_url
    response = self.class.get('/v1/images/search')
    JSON.parse(response.body).first['url'] if response.code == 200
  end
end

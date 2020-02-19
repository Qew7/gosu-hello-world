class CatApiClient
  include HTTParty

  base_uri 'meowfacts.herokuapp.com'

  def cat_fact
    response = self.class.get('')
    JSON.parse(response.body)['data'].first if response.code == 200
  end
end

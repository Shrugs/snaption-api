class FacebookInfoFetcher
  def initialize(access_token)
    @graph = Koala::Facebook::API.new(access_token)
  end

  def user_info
    profile = @graph.get_object('me').with_indifferent_access
    fb_id = profile[:id]
    {
      display_name: profile[:name],
      profile_image_url: "https://graph.facebook.com/#{fb_id}/picture?type=large"
    }
  end
end

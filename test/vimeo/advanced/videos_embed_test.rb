require 'test_helper'

class VideoEmbedTest < Test::Unit::TestCase

  context "vimeo advanced video embed" do
    
    setup do
      @video_embed = Vimeo::Advanced::VideoEmbed.new("12345", "secret", :token => "token", :secret => "secret")
    end

    should "be able to get a list presets for video embeds" do
      stub_post("?api_key=12345&format=json&method=vimeo.video.embed.getPresets&auth_token=token&api_sig=37baebafad1eafc408b9789e9f0115be", "advanced/video_embed/get_presets.json")

      assert_raise(Vimeo::Advanced::RequestFailed) do
        response = @video_embed.get_presets
      end
    end
    
    should "be able to set the preset of a video embed" do
      stub_post("?preset_id=preset_id&video_id=video_id&api_key=12345&format=json&method=vimeo.video.embed.setPreset&auth_token=token&api_sig=116e80503e8273a6b4475b8561c2818b", "advanced/video_embed/set_preset.json")
      response = @video_embed.set_preset("video_id", "preset_id")
      
      assert_equal "ok", response["stat"]
    end

  end
end
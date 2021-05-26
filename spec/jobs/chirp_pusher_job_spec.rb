require 'rails_helper'
require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

describe ChirpPusherJob, type: :job do
  describe "perform" do
    it "calls to push out the chirp" do
      stub_request(:post, "https://bellbird.joinhandshake-internal.com/push/").
        with(
          body: {"id"=>"123"},
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type'=>'application/x-www-form-urlencoded',
            'Host'=>'bellbird.joinhandshake-internal.com',
            'User-Agent'=>'Ruby'
          }).
        to_return(status: 200, body: "", headers: {})


      described_class.perform_now(123)

      expect(
        a_request(:post, "https://bellbird.joinhandshake-internal.com/push/")
      ).to have_been_made
    end
  end
end

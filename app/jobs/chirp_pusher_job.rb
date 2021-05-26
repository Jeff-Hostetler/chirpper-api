class ChirpPusherJob < ApplicationJob
  queue_as :default
  require "net/http"

  def perform(chirp_id)
    uri = URI("https://bellbird.joinhandshake-internal.com/push/")
    Net::HTTP.post_form(uri, id: chirp_id)
  end
end

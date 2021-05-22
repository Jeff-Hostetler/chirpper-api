module Chirpper
  module V1
    class ChirpsController < ApplicationController

      def index
        chirps = ActiveModel::Serializer::CollectionSerializer.new(
          Chirp.all, each_serializer: ChirpSerializer
        )
        render json: {chirps: chirps}
      end

    end
  end
end
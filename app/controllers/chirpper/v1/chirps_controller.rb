module Chirpper
  module V1
    class ChirpsController < ApplicationController

      def index
        chirps = ActiveModel::Serializer::CollectionSerializer.new(
          Chirp.all, each_serializer: ChirpSerializer
        )
        render json: {chirps: chirps}
      end

      def create
        chirp = Chirp.new(create_params)
        if chirp.save
          render json: {chirp: ChirpSerializer.new(chirp)}, status: :created
        end
      end


      private

      def create_params
        params.permit(:text)
      end
    end
  end
end
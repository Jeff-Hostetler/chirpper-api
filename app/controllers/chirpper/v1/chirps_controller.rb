module Chirpper
  module V1
    class ChirpsController < ApplicationController
      def index
        popular_chirps = Chirp.popular
        chirps = Chirp.default_order.where.not(id: popular_chirps.pluck(:id))

        render json: {
          popular_chirps: popular_chirps,
          chirps: chirps
        }
      end

      def create
        chirp = Chirp.new(create_params)
        if chirp.save
          ChirpPusherJob.perform_later(chirp.id)
          render json: {chirp: ChirpSerializer.new(chirp)}, status: :created
        end
      end

      def upvote
        chirp = Chirp.find(params[:id])
        chirp.upvote
        render json: {chirp: ChirpSerializer.new(chirp)}
      end


      private

      def create_params
        params.permit(:text)
      end
    end
  end
end
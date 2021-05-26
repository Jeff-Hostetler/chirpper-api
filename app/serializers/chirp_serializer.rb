class ChirpSerializer < ActiveModel::Serializer
  attributes(:id, :text, :upvotes)
end

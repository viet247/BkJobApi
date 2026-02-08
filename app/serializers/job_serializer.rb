class JobSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :salary
  
  belongs_to :city
  belongs_to :company
end

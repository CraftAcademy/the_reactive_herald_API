class Articles::ShowSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :image

  def image
    if Rails.env.test?
      rails_blob_url(object.image)
    else
      object.image.service_url(expires_in: 1.hour, disposition: 'inline')
  end
end

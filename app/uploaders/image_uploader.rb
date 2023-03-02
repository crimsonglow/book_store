class ImageUploader < Shrine
  Attacher.default_url do
    '/default.png'
  end
end

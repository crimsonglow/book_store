require 'image_processing/mini_magick'
require 'mini_magick'

class ImageUploader < Shrine
  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)

    {
      slider: magick.resize_to_fit!(250, nil),
      large: magick.resize_to_fit!(555, nil),
      medium: magick.resize_to_fit!(157, nil),
      small: magick.resize_to_fit!(88, nil)
    }
  end

  Attacher.default_url do
    '/default.png'
  end
end

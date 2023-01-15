ActiveAdminAddons::ImageBuilder.class_eval do
  alias old_render render

  def render # 1.9版本适用，1.9以后的版本需要重构，因为1.9以后ActiveAdminAddons改造了该方法，支持了更多的source.
    return nil if data.nil?
    return old_render if not data.is_a? CarrierWave::Uploader::Base
    style = options.fetch(:style, :original)
    context.image_tag(data.url(style)) if data.file
  end

  def carrierwave_data
    style = options.fetch(:style, :original)
    context.image_tag(data.url(style)) if data.file
  end
end
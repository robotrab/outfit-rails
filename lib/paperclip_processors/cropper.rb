module Paperclip
  class Cropper < Thumbnail
    def transformation_command
      if @options[:geometry] == "profile"
        profile_crop
      elsif @options[:geometry] == "mobile"
        mobile_crop
      else
        super
      end
    end

    def profile_crop
      target = @attachment.instance
      if target.cropping?
        ["-crop", "#{target.crop_w}x#{target.crop_h}+#{target.crop_x}+#{target.crop_y}", "+repage", "-resize", "364x646"]
      else
        ["-resize", "364x646"]
      end
    end

    def mobile_crop
      target = @attachment.instance
      if target.cropping?
        ["-crop", "#{target.crop_w}x#{target.crop_h}+#{target.crop_x}+#{target.crop_y}", "+repage", "-resize", "256x455"]
      else
        ["-resize", "256x455"]
      end
    end
  end
end

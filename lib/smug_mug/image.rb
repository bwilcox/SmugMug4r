module SmugMug4r
  module SmugMug
  
    # Data model representation of a smugmug image.
    #
    # === Attributes
    # * +id+ -- image id
    # * +key+ -- image key
    class Image < ActiveResource::Base
      #member :id,            :int
      #member :key,           :string
      #member :album_id,      :int
      #member :album_key,     :string
      #member :file_name,     :string
      #member :caption,       :string
      #member :keywords,      :string
      #member :position,      :int
      #member :date,          :string
      #member :format,        :string
      #member :serial,        :int
      #member :hidden,        :boolean
      #member :size,          :int
      #member :width,         :int
      #member :height,        :int
      #member :md5sum,        :string
      #member :last_updated,  :string
      #member :album_url,     :string
      #member :tiny_url,      :string
      #member :thumb_url,     :string
      #member :small_url,     :string
      #member :medium_url,    :string
      #member :large_url,     :string
      #member :x_large_url,   :string
      #member :x2_large_url,  :string
      #member :x3_large_url,  :string
      #member :original_url,  :string
      #member :video320_url,  :string
      #member :video640_url,  :string
      #member :video960_url,  :string
      #member :video1280_url, :string
      #member :latitude,      :string
      #member :longitude,    :string
      #member :altitude,      :string
      
      # Converts a smugmug JSON string into an Item object.
      def self.decode(json)
        image = Image.new
        image.id = json["id"]
        image.key = json["Key"]
        image.album_id = json["Album"]["id"] if json["Album"]
        image.album_key = json["Album"]["Key"] if json["Album"]
        image.file_name = json["FileName"]
        image.caption = json["Caption"]
        image.keywords = json["Keywords"]
        image.position = json["Position"]
        image.date = json["Date"]
        image.format = json["Format"]
        image.serial = json["Serial"]
        image.hidden = json["Hidden"]
        image.size = json["Size"]
        image.width = json["Width"]
        image.height = json["Height"]
        image.md5sum = json["MD5Sum"]
        image.last_updated = json["LastUpdated"]
        image.album_url = json["AlbumURL"]
        image.tiny_url = json["TinyURL"]
        image.thumb_url = json["ThumbURL"]
        image.small_url = json["SmallURL"]
        image.medium_url = json["MediumURL"]
        image.large_url = json["LargeURL"]
        image.x_large_url = json["XLargeURL"]
        image.x2_large_url = json["X2LargeURL"]
        image.x3_large_url = json["X3LargeURL"]
        image.original_url = json["OriginalURL"]
        image.video320_url = json["Video320URL"]
        image.video640_url = json["Video640URL"]
        image.video960_url = json["Video960URL"]
        image.video1280_url = json["Video1280URL"]
        image.latitude = json["Latitude"]
        image.longitude = json["Longitude"]
        image.altitude = json["Altitude"]
        return image
      end
    end

    # This is a class for working with SmugMug images. All methods require
    # a logged in <tt>Session</tt>. Use like this:
    # 
    #   # Establish a session
    #   session = Session.new("YOUR-API-KEY")
    #   session.login_anonymously
    #   
    #   # Return an array of album objects
    #   albums = Albums.get(session, {:NickName => "barriault"})
    #   
    #   # Return an array of image objects for an album
    #   images = Images.get(session, albums[0])
    #
    class Images
      
      def self.change_position(session, image, position)
        # TODO
      end
      
      def self.change_settings()
        # TODO
      end
      
      # Deletes an existing image.
      #
      # === Arguments
      # * +session+ -- a logged in Session
      # * +album+ -- an Image or ImageID
      #
      # === Exceptions
      #
      # * +SmugMugError+ -- generic exception class
      #
      def self.delete(session, image)
        parameters = {}
        if image.instance_of?(Image)
          parameters[:ImageID] = image.id
        else
          parameters[:ImageID] = image
        end
        
        session.call("smugmug.images.delete", parameters)
      end
      
      # Retrieves a list of images for a given album.
      #
      # === Arguments
      # * +session+ -- a logged in Session
      # * +album+ -- an Album or AlbumID (if AlbumID you must pass :AlbumKey in the options hash)
      #
      # === Options
      # * <tt>:Heavy</tt> -- boolean (optional)
      # * <tt>:Password</tt> -- string (optional)
      # * <tt>:SitePassword</tt> -- string (optional)
      # 
      # === Exceptions
      #
      # * +SmugMugError+ -- generic exception class
      #
      def self.get(session, album, options = {})
        parameters = {}
        if album.instance_of?(Album)
          parameters[:AlbumID] = album.id
          parameters[:AlbumKey] = album.key
        else
          parameters[:AlbumID] = album
        end
        parameters.merge!(options)

        json = session.call("smugmug.images.get", parameters)
        images = []
        json["Album"]["Images"].each do |image|
          images << Image.decode(image)
        end
        return images
      end
      
      def self.get_exif(session, image, options = {})
        parameters = {}
        if image.instance_of?(Image)
          parameters[:ImageID] = image.id
          parameters[:ImageKey] = image.key
        else
          parameters[:ImageID] = image
        end
        parameters.merge!(options)

        json = session.call("smugmug.images.getEXIF", parameters)
        # TODO Return an exif object
        return json
      end
      
      # Retrieves a single image with all data similar to calling get with the
      # :Heavy option for a given Image or ImageID. If giving just the ImageID
      # you must also pass the :ImageKey in the options hash.
      #
      # === Arguments
      # * +session+ -- a logged in Session
      # * +album+ -- an Image or ImageID (if ImageID you must pass :ImageKey in the options hash)
      #
      # === Options
      # * <tt>:Password</tt> -- string (optional)
      # * <tt>:SitePassword</tt> -- string (optional)
      # 
      # === Exceptions
      #
      # * +SmugMugError+ -- generic exception class
      #
      def self.get_info(session, image, options = {})
        parameters = {}
        if image.instance_of?(Image)
          parameters[:ImageID] = image.id
          parameters[:ImageKey] = image.key
        else
          parameters[:ImageID] = image
        end
        parameters.merge!(options)

        json = session.call("smugmug.images.getInfo", parameters)
        return Image.decode(json)
      end
      
      def self.get_stats(session, image, month)
        # TODO
      end
      
      def self.get_urls(session, image, options = {})
        parameters = {}
        if image.instance_of?(Image)
          parameters[:ImageID] = image.id
          parameters[:ImageKey] = image.key
        else
          parameters[:ImageID] = image
        end
        parameters.merge!(options)

        json = session.call("smugmug.images.getInfo", parameters)
        # TODO Return something other than json
        return json
      end
      
      def self.upload(session, album, caption, file_name, data, byte_count, md5sum)
        # TODO
      end
      
      def self.upload_from_url(session, album, url, options = {})
        # TODO
      end
      
    end
    
  end
end
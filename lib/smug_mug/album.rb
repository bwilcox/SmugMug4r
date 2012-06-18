module SmugMug4r
  module SmugMug
  
    # Data model representation of a smugmug album. Attributes may or may not
    # contain values depending on what methods are used to retrieve the album.
    #
    # === Attributes
    # * +id+ -- the album's ID
    # * +key+ -- the album's key
    # * +title+ -- the album's title
    # * +category_id+ -- the album's Category ID
    # * +category_name+ -- the album's Category name
    # * +subcategory_id+ -- the album's SubCategory ID
    # * +subcategory_name+ -- the album's SubCategory name
    # * +description+ -- string
    # * +keywords+ -- string
    # * +geography+ -- boolean
    # * +position+ -- int
    # * +highlight_id+ -- int
    # * +image_count+ -- int
    # * +last_updated+ -- string
    # * +header+ -- boolean
    # * +clean+ -- boolean
    # * +exif+ -- boolean
    # * +filenames+ -- boolean
    # * +template_id+ -- int
    # * +sort_method+ -- string
    # * +sort_direction+ -- boolean
    # * +passworded+ -- boolean
    # * +password+ -- string
    # * +password_hint+ -- string
    # * +public+ -- boolean
    # * +world_searchable+ -- boolean
    # * +smug_searchable+ -- boolean
    # * +external+ -- boolean
    # * +protected+ -- boolean
    # * +watermarking+ -- boolean
    # * +watermark_id+ -- int
    # * +hide_owner+ -- boolean
    # * +larges+ -- boolean
    # * +xlarges+ -- boolean
    # * <tt>x2larges</tt> -- boolean
    # * <tt>x3larges</tt> -- boolean
    # * +originals+ -- boolean
    # * +can_rank+ -- boolean
    # * +friend_edit+ -- boolean
    # * +family_edit+ -- boolean
    # * +comments+ -- boolean
    # * +share+ -- boolean
    # * +printable+ -- boolean
    # * +default_color+ -- boolean
    # * +proof_days+ -- int
    # * +backprinting+ -- string
    # * +unsharp_amount+ -- float
    # * +unsharp_radius+ -- float
    # * +unsharp_threshold+ -- float
    # * +unsharp_sigma+ -- float
    # * +community_id+ -- int
    class Album < ActionWebService::Struct
      member :id,                :int
      member :key,               :string
      member :title,             :string
      member :category_id,       :int
      member :category_name,     :string
      member :subcategory_id,    :int
      member :subcategory_name,  :string
      member :description,       :string
      member :keywords,          :string
      member :geography,         :boolean
      member :position,          :int
      member :highlight_id,      :int
      member :image_count,       :int
      member :last_updated,      :string
      member :header,            :boolean
      member :clean,             :boolean
      member :exif,              :boolean
      member :filenames,         :boolean
      member :template_id,       :int
      member :sort_method,       :string
      member :sort_direction,    :boolean
      member :passworded,        :boolean
      member :password,          :string
      member :password_hint,     :string
      member :public,            :boolean
      member :world_searchable,  :boolean
      member :smug_searchable,   :boolean
      member :external,          :boolean
      member :protected,         :boolean
      member :watermarking,      :boolean
      member :watermark_id,      :int
      member :hide_owner,        :boolean
      member :larges,            :boolean
      member :xlarges,           :boolean
      member :x2larges,          :boolean
      member :x3larges,          :boolean
      member :originals,         :boolean
      member :can_rank,          :boolean
      member :friend_edit,       :boolean
      member :family_edit,       :boolean
      member :comments,          :boolean
      member :share,             :boolean
      member :printable,         :boolean
      member :default_color,     :boolean
      member :proof_days,        :int
      member :backprinting,      :string
      member :unsharp_amount,    :float
      member :unsharp_radius,    :float
      member :unsharp_threshold, :float
      member :unsharp_sigma,     :float
      member :community_id,      :int


      def self.decode(json)
          album = Album.new
          album.id = json["id"]
          album.key = json["Key"]
          album.title = json["Title"]
          album.category_id = json["Category"]["id"] if json["Category"]
          album.category_name = json["Category"]["Name"] if json["Category"]
          album.subcategory_id = json["SubCategory"]["id"] if json["SubCategory"]
          album.subcategory_name = json["SubCategory"]["Name"] if json["SubCategory"]
          album.description = json["Description"]
          album.keywords = json["Keywords"]
          album.geography = json["Geography"]
          album.position = json["Position"]
          album.highlight_id = json["Highlight"]["id"] if json["Highlight"]
          album.image_count = json["ImageCount"]
          album.last_updated = json["LastUpdated"]
          album.header = json["Header"]
          album.clean = json["Clean"]
          album.exif = json["EXIF"]
          album.filenames = json["Filenames"]
          album.template_id = json["Template"]["id"] if json["Template"]
          album.sort_method = json["SortMethod"]
          album.sort_direction = json["SortDirection"]
          album.passworded = json["Passworded"]
          album.password = json["Password"]
          album.password_hint = json["PasswordHint"]
          album.public = json["Public"]
          album.world_searchable = json["WorldSearchable"]
          album.smug_searchable = json["SmugSearchable"]
          album.external = json["External"]
          album.protected = json["Protected"]
          album.watermarking = json["Watermarking"]
          album.watermark_id = json["Watermark"]["id"] if json["Watermark"]
          album.hide_owner = json["HideOwner"]
          album.larges = json["Larges"]
          album.xlarges = json["XLarges"]
          album.x2larges = json["X2Larges"]
          album.x3larges = json["X3Larges"]
          album.originals = json["Originals"]
          album.can_rank = json["CanRank"]
          album.friend_edit = json["FriendEdit"]
          album.family_edit = json["FamilyEdit"]
          album.comments = json["Comments"]
          album.share = json["Share"]
          album.printable = json["Printable"]
          album.default_color = json["DefaultColor"]
          album.proof_days = json["ProofDays"]
          album.backprinting = json["Backprinting"]
          album.unsharp_amount = json["UnsharpAmount"]
          album.unsharp_radius = json["UnsharpRadius"]
          album.unsharp_threshold = json["UnsharpThreshold"]
          album.unsharp_sigma = json["UnsharpSigma"]
          album.community_id = json["Community"]["id"] if json["Community"]
          return album
      end
      
    end

    class Albums
      
      # Change the settings of an existing album.
      #
      # === Arguments
      # * +session+ -- a logged in Session
      # * +album+ -- an Album or AlbumID
      # 
      # === Essential Options
      # * <tt>:AlbumTemplateID</tt> -- integer (optional)
      # * <tt>:Title</tt> -- string (optional)
      # * <tt>:CategoryID</tt> -- integer (optional)
      # * <tt>:SubCategoryID</tt> -- integer (optional)
      # * <tt>:Description</tt> -- string (optional)
      # * <tt>:Keywords</tt> -- string (optional)
      # * <tt>:Geography</tt> -- boolean (optional)
      #
      # === Look and Feel Options
      # * <tt>:Header</tt> -- boolean (optional, power and pro only)
      # * <tt>:Clean</tt> -- boolean (optional)
      # * <tt>:EXIF</tt> -- boolean (optional)
      # * <tt>:Filenames</tt> -- boolean (optional)
      # * <tt>:TemplateID</tt> -- integer (optional, power and pro only)
      #   * 0: Viewer Choice (default)
      #   * 3: SmugMug
      #   * 4: Traditional
      #   * 7: All Thumbs
      #   * 8: Slideshow
      #   * 9: Journal
      #   * 10: SmugMug Small
      #   * 11: Filmstrip
      # * <tt>:SortMethod</tt> -- string (optional)
      #   * Position (default)
      #   * Caption
      #   * FileName
      #   * Date
      #   * DateTime
      #   * DateTimeOriginal
      # * <tt>:SortDirection</tt> -- boolean (optional)
      #   * 0: Ascending (1-99, A-Z, 1980-2004, etc)
      #   * 1: Descending (99-1, Z-A, 2004-1980, etc)
      #   
      # === Security and Privacy Options
      # TODO
      # 
      # === Social Options
      # TODO
      # 
      # === Printing and Sales Options
      # TODO
      # 
      # === Photo Sharpening Options
      # TODO
      # 
      # === Community Options
      # TODO
      # 
      # === Exceptions
      #
      # * +SmugMugError+ -- generic exception class
      #
      def self.change_settings(session, album, options = {})
        parameters = {}
        if album.instance_of?(Album)
          parameters[:AlbumID] = album.id
        else
          parameters[:AlbumID] = album
        end
        parameters.merge!(options)
        
        json = session.call("smugmug.albums.changeSettings", parameters)
        Album.get_info(session, Album.decode(json))
      end
      
      # Creates a new album with the specified arguments and options.
      #
      # === Arguments
      # * +session+ -- a logged in Session
      # * +title+ -- a title
      # * +category+ -- a Category or CategoryID
      # * +options+ -- a hash containing optional arguments
      # 
      # === Essential Options
      # * <tt>:AlbumTemplateID</tt> -- integer (optional)
      # * <tt>:SubCategoryID</tt> -- integer (optional)
      # * <tt>:Description</tt> -- string (optional)
      # * <tt>:Keywords</tt> -- string (optional)
      # * <tt>:Geography</tt> -- boolean (optional)
      #
      # === Look and Feel Options
      # * <tt>:Header</tt> -- boolean (optional, power and pro only)
      # * <tt>:Clean</tt> -- boolean (optional)
      # * <tt>:EXIF</tt> -- boolean (optional)
      # * <tt>:Filenames</tt> -- boolean (optional)
      # * <tt>:TemplateID</tt> -- integer (optional, power and pro only)
      #   * 0: Viewer Choice (default)
      #   * 3: SmugMug
      #   * 4: Traditional
      #   * 7: All Thumbs
      #   * 8: Slideshow
      #   * 9: Journal
      #   * 10: SmugMug Small
      #   * 11: Filmstrip
      # * <tt>:SortMethod</tt> -- string (optional)
      #   * Position (default)
      #   * Caption
      #   * FileName
      #   * Date
      #   * DateTime
      #   * DateTimeOriginal
      # * <tt>:SortDirection</tt> -- boolean (optional)
      #   * 0: Ascending (1-99, A-Z, 1980-2004, etc)
      #   * 1: Descending (99-1, Z-A, 2004-1980, etc)
      #   
      # === Security and Privacy Options
      # TODO
      # 
      # === Social Options
      # TODO
      # 
      # === Printing and Sales Options
      # TODO
      # 
      # === Photo Sharpening Options
      # TODO
      # 
      # === Community Options
      # TODO
      # 
      # === Exceptions
      #
      # * +SmugMugError+ -- generic exception class
      #
      def self.create(session, title, category, options = {})
        parameters = {}
        parameters[:Title] = title
        if category.instance_of?(Category)
          parameters[:CategoryID] = category.id
        else
          parameters[:CategoryID] = category
        end
        parameters.merge!(options)
        
        json = session.call("smugmug.albums.create", parameters)
        Album.get_info(session, Album.decode(json))
      end
      
      # Deletes an existing album.
      #
      # === Arguments
      # * +session+ -- a logged in Session
      # * +album+ -- an Album or AlbumID
      #
      # === Exceptions
      #
      # * +SmugMugError+ -- generic exception class
      #
      def self.delete(session, album)
        parameters = {}
        if album.instance_of?(Album)
          parameters[:AlbumID] = album.id
        else
          parameters[:AlbumID] = album
        end
        
        session.call("smugmug.albums.delete", parameters)
      end
      
      # Retrieves a list of albums for a given user.
      #
      # === Arguments
      # * +session+ -- a logged in Session
      #
      # === Options
      # * <tt>:NickName</tt> -- string (optional)
      # * <tt>:Heavy</tt> -- boolean (optional)
      # * <tt>:SitePassword</tt> -- string (optional)
      # 
      # === Exceptions
      #
      # * +SmugMugError+ -- generic exception class
      #
      def self.get(session, options = {})
        parameters = {}
        parameters.merge!(options)

        json = session.call("smugmug.albums.get", parameters)
        albums = []
        json["Albums"].each do |alb|
          albums << Album.decode(alb)
        end
        return albums
      end
      
      # Retrieves a single album with all data similar to calling get with the
      # :Heavy option for a given Album or AlbumID. If giving just the AlbumID
      # you must also pass the :AlbumKey in the options hash. 
      #
      # === Arguments
      # * +session+ -- a logged in Session
      # * +album+ -- an Album or AlbumID (if AlbumID you must pass :AlbumKey in the options hash)
      #
      # === Options
      # * <tt>:Password</tt> -- string (optional)
      # * <tt>:SitePassword</tt> -- string (optional)
      # 
      # === Exceptions
      #
      # * +SmugMugError+ -- generic exception class
      #
      def self.get_info(session, album, options = {})
        parameters = {}
        if album.instance_of?(Album)
          parameters[:AlbumID] = album.id
          parameters[:AlbumKey] = album.key
        else
          parameters[:AlbumID] = album
        end
        parameters.merge!(options)

        json = session.call("smugmug.albums.getInfo", parameters)
        alb = json["Album"]
        return Album.decode(alb)
      end
      
      # This method is not yet implemented.
      def self.get_stats()
        # TODO
      end
      
      # This method is not yet implemented.
      def self.re_sort()
        # TODO
      end
      
    end
    
  end
end
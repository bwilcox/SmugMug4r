module SmugMug4r
  module SmugMug
  
    # Data model representation of a smugmug subcategory.
    #
    # === Attributes
    # * +id+ -- The SubCategory ID.
    # * +name+ -- The SubCategory Name.
    # * +albums+ -- an array of Album objects
    class SubCategory < ActionWebService::Struct
      member :id,     :int
      member :name,   :string
      member :albums, [Album]
      
      # Converts a smugmug JSON string into a SubCategory object.
      def self.decode(json)
        subcategory = SubCategory.new
        subcategory.id = json["id"]
        subcategory.name = json["Name"]
        
        if json["Albums"]
          albums = []
          json["Albums"].each do |album|
            albums << Album.decode(album)
          end
          subcategory.albums = albums
        end
        
        return subcategory
      end
    end

    # This is a class for working with SmugMug SubCategories. All methods 
    # require a logged in <tt>Session</tt>. Use like this:
    # 
    #   # Establish a session
    #   session = Session.new("YOUR-API-KEY")
    #   session.login_anonymously
    #   
    #   # Get some categories
    #   categories = Categories.get(session, {:NickName => "nickname"})
    #   
    #   # Return an array of category objects
    #   subcats = SubCategories.get(session, category[0], {:NickName => "nickname"})
    #
    class SubCategories
      
      # Creates a new SubCategory with the given name within a specified 
      # Category.
      #
      # === Arguments
      # * +session+ -- a logged in Session
      # * +name+ -- a subcategory name
      # * +category+ -- a Category or CategoryID
      #
      # === Exceptions
      #
      # * +SmugMugError+ -- generic exception class
      #
      def self.create(session, category, name)
        parameters = {}
        if category.instance_of?(Category)
          parameters[:CategoryID] = category.id
        else
          parameters[:CategoryID] = category
        end
        parameters[:Name] = name
        
        json = session.call("smugmug.subcategories.create", parameters)
        SubCategory.new(:name => name, :id => json["SubCategory"]["id"])
      end
      
      # Deletes an existing subcategory.
      #
      # === Arguments
      # * +session+ -- a logged in Session
      # * +subcategory+ -- a SubCategory or SubCategoryID
      #
      # === Exceptions
      #
      # * +SmugMugError+ -- generic exception class
      #
      def self.delete(session, subcategory)
        parameters = {}
        if subcategory.instance_of?(SubCategory)
          parameters[:SubCategoryID] = subcategory.id
        else
          parameters[:SubCategoryID] = subcategory
        end
        
        session.call("smugmug.subcategories.delete", parameters)
      end
      
      # Retrieves an array of SubCategory objects within a specified Category 
      # for a given user.
      #
      # === Arguments
      # * +session+ -- a logged in Session
      # * +category+ -- a Category or CategoryID
      # * +options+ -- a hash containing optional arguments
      # 
      # === Options
      # * <tt>:NickName</tt> -- a nick name (usually used with anonymous login)
      # * <tt>:SitePassword</tt> -- a site password
      #
      # === Exceptions
      #
      # * +SmugMugError+ -- generic exception class
      #
      def self.get(session, category, options = {})
        parameters = {}
        if category.instance_of?(Category)
          parameters[:CategoryID] = category.id
        else
          parameters[:CategoryID] = category
        end
        parameters.merge!(options)

        json = session.call("smugmug.subcategories.get", parameters)
        subcategories = []
        json["SubCategories"].each do |subcategory|
          subcategories << SubCategory.decode(subcategory)
        end
        return subcategories
      end
      
      # Renames an existing subcategory with the given name. Returns the 
      # SubCategory object with the new name.
      #
      # === Arguments
      # * +session+ -- a logged in Session
      # * +subcategory+ -- a SubCategory or SubCategoryID
      # * +name+ -- the new name
      #
      # === Exceptions
      #
      # * +SmugMugError+ -- generic exception class
      #
      def self.rename(session, subcategory, name)
        parameters = {}
        if subcategory.instance_of?(SubCategory)
          parameters[:SubCategoryID] = subcategory.id
        else
          parameters[:SubCategoryID] = subcategory
        end
        parameters[:Name] = name
        
        json = session.call("smugmug.subcategories.rename", parameters)
        if subcategory.instance_of?(SubCategory)
          subcategory.name = name
          return subcategory
        else
          return SubCategory.new(:name => name, :id => json["SubCategory"]["id"])
        end
      end
      
    end
    
  end
end
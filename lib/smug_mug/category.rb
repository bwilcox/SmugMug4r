module SmugMug4r
  module SmugMug
  
    # Data model representation of a smugmug category.
    #
    # === Attributes
    # * +id+ -- category id
    # * +name+ -- category name
    # * +subcategories+ -- an array Subcategory objects
    # * +albums+ -- an array of Album objects
    class Category < ActiveResource::Base
      #member :id,            :int
      #member :name,          :string
      #member :subcategories, [SubCategory]
      #member :albums,        [Album]
      
      # Converts a smugmug JSON string into a Category object.
      def self.decode(json)
        category = Category.new
        category.id = json["id"]
        category.name = json["Name"]
        
        if json["SubCategories"]
          subcategories = []
          json["SubCategories"].each do |subcategory|
            subcategories << SubCategory.decode(subcategory)
          end
          category.subcategories = subcategories
        end
        
        if json["Albums"]
          albums = []
          json["Albums"].each do |album|
            albums << Album.decode(album)
          end
          category.albums = albums
        end
        
        return category
      end
    end

    # This is a class for working with SmugMug categories. All methods require
    # a logged in <tt>Session</tt>. Use like this:
    # 
    #   # Establish a session
    #   session = Session.new("YOUR-API-KEY")
    #   session.login_anonymously
    #   
    #   # Return an array of category objects
    #   categories = Categories.get(session, {:NickName => "nickname"})
    #
    class Categories
      
      # Creates a new category with the given name.
      #
      # === Arguments
      # * +session+ -- a logged in Session
      # * +name+ -- a category name
      #
      # === Exceptions
      #
      # * +SmugMugError+ -- generic exception class
      #
      def self.create(session, name)
        parameters = {}
        parameters[:Name] = name
        
        json = session.call("smugmug.categories.create", parameters)
        Category.new(:name => name, :id => json["Category"]["id"])
      end
      
      # Deletes an existing category.
      #
      # === Arguments
      # * +session+ -- a logged in Session
      # * +category+ -- a Category or CategoryID
      #
      # === Exceptions
      #
      # * +SmugMugError+ -- generic exception class
      #
      def self.delete(session, category)
        parameters = {}
        if category.instance_of?(Category)
          parameters[:CategoryID] = category.id
        else
          parameters[:CategoryID] = category
        end
        
        session.call("smugmug.categories.delete", parameters)
      end
      
      # Retrieves an array of Category objects for a given user.
      #
      # === Arguments
      # * +session+ -- a logged in Session
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
      def self.get(session, options = {})
        parameters = {}
        parameters.merge!(options)

        json = session.call("smugmug.categories.get", parameters)
        categories = []
        json["Categories"].each do |cat|
          categories << Category.decode(cat)
        end
        return categories
      end
      
      # Renames an existing category with the given name. Returns the Category
      # object with the new name.
      #
      # === Arguments
      # * +session+ -- a logged in Session
      # * +category+ -- a Category or CategoryID
      # * +name+ -- the new name
      #
      # === Exceptions
      #
      # * +SmugMugError+ -- generic exception class
      #
      def self.rename(session, category, name)
        parameters = {}
        if category.instance_of?(Category)
          parameters[:CategoryID] = category.id
        else
          parameters[:CategoryID] = category
        end
        parameters[:Name] = name
        
        json = session.call("smugmug.categories.rename", parameters)
        if category.instance_of?(Category)
          category.name = name
          return category
        else
          return Category.new(:name => name, :id => json["Category"]["id"])
        end
      end
      
    end
    
  end
end
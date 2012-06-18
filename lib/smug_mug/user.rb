module SmugMug4r
  module SmugMug
    
    class Users
      
      # This method returns a complete tree, starting with an array of 
      # Categories and descending into SubCategories (if any) and 
      # Albums (if any).
      #
      # === Arguments
      # * +session+ -- a logged in Session
      # * +options+ -- a Hash of optional arguments
      # 
      # === Optional Arguments
      # * <tt>:NickName</tt>
      # * <tt>:Heavy</tt>
      # * <tt>:SitePassword</tt>
      # 
      # === Exceptions
      #
      # * +SmugMugError+ -- generic smugmug error class
      #
      def self.get_tree(session, options = {})
        json = session.call("smugmug.users.getTree", options)
        
        categories = []
        json["Categories"].each do |category|
          categories << Category.decode(category)
        end
        return categories
      end
      
    end

  end
end
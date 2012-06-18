module SmugMug4r
  module SmugMug
    
    # Generic error class for all SmugMug errors
    class SmugMugError < StandardError
    end
    
    # Class to establish a SmugMug session. Use it like this:
    #
    #   session = Session.new("YOUR-API-KEY")
    #   session.login_anonymously
    #   
    #   or like this:
    #   
    #   session = Session.new("YOUR-API-KEY")
    #   session.login("email_address", "password")
    #   . . .
    #   session.logout
    #   
    # All of the login methods return the JSON result from SmugMug.
    #
    class Session
      
      # Accessor for the API key.
      attr :api_key
      
      # Accessor for the session ID. This will have a value only if logged in
      # successfully.
      attr :session_id
      
      # Accessor for the user ID. This will have a value only after using
      # the normal +login+ method with user email and password.
      attr :user_id

      # Accessor for the password hash. This will have a value only after using
      # the normal +login+ method with user email and password.
      attr :password_hash

      # Initializes a new session with the given API key.
      #
      # === Arguments
      # * +api_key+ -- a valid SmugMug API key
      def initialize(api_key)
        @api_key = api_key
      end

      # Establishes a session and logs a user in based on the specified email 
      # address (or nickname) and password.
      #
      # === Arguments
      # * +username+ -- an email address or nickname
      # * +password+ -- a password.
      #
      # === Exceptions
      #
      # * +SmugMugError+ -- generic exception class
      #
      def login(username, password)
        parameters = {}
        parameters[:EmailAddress] = username
        parameters[:Password] = password

        json = call_secure("smugmug.login.withPassword", parameters)
        @session_id = json["Login"]["Session"]["id"]
        @user_id = json["Login"]["User"]["id"]
        @password_hash = json["Login"]["PasswordHash"]
        return json
      end
      
      # Establishes an anonymous session.
      #
      # === Exceptions
      #
      # * +SmugMugError+ -- generic exception class
      #
      def login_anonymously()
        json = call("smugmug.login.anonymously")
        @session_id = json["Login"]["Session"]["id"]
        return json
      end

      # Establishes a session and logs a user in based on the specified user id 
      # and password hash.
      #
      # === Arguments
      # * +user_id+ -- a user ID
      # * +password_hash+ -- a password hash
      #
      # === Exceptions
      #
      # * +SmugMugError+ -- generic exception class
      #
      def login_with_hash(user_id, password_hash)
        parameters = {}
        parameters[:UserID] = user_id
        parameters[:PasswordHash] = password_hash

        json = call_secure("smugmug.login.withHash", parameters)
        @session_id = json["Login"]["Session"]["id"]
        return json
      end

      # Terminates a session and logs the user out. Logging out from an 
      # anonymous login will raise an error.
      #
      # === Exceptions
      #
      # * +SmugMugError+ -- generic exception class
      #
      def logout()
        parameters = {}
        parameters[:APIKey] = api_key
        parameters[:SessionID] = session_id

        json = call("smugmug.logout", parameters)
        @session_id = nil
        @password_hash = nil
        return json
      end

      def call(method, params = {})
        parameters = params.dup
        parameters[:method] = method
        parameters[:APIKey] = api_key
        parameters[:SessionID] = @session_id if @session_id

        response = http.get(path_for_params(parameters))
        json = JSON.parse(response.body)
        if json["stat"] == "fail"
          raise SmugMugError.new(json["message"])
        end
        return json
      end

      def call_secure(method, params = {})
        parameters = params.dup
        parameters[:method] = method
        parameters[:APIKey] = api_key
        parameters[:SessionID] = @session_id if @session_id

        https.use_ssl = true
        response = https.get(path_for_params(parameters))
        json = JSON.parse(response.body)
        if json["stat"] == "fail"
          raise SmugMugError.new(json["message"])
        end
        return json
      end
      
      private

      def path_for_params(params)
        query_string = "?" + params.inject([]) { |qs, pair| qs << "#{CGI.escape(pair[0].to_s)}=#{CGI.escape(pair[1].to_s)}"; qs }.join("&")
        query_string = "/services/api/json/1.2.1/" + query_string
        puts query_string if ENV["RAILS_ENV"] == "development"
        return query_string
      end

      def http
        @http ||= Net::HTTP.new("api.smugmug.com", 80)
      end

      def https
        @https ||= Net::HTTP.new("api.smugmug.com", 443)
      end

    end

  end
end

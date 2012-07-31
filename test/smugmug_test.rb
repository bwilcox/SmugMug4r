require 'test/unit'
require 'parseconfig'
require 'smug_mug4r.rb'

class SmugmugTest < Test::Unit::TestCase
  
  def setup
    # Read in the configuration for testing
    config = ParseConfig.new('./test/private.config')

    # Set variables based on the configuration file
    @api_key = config['api_key']
    @user = config['username']
    @password = config['password']
    @nickname = config['nickname']
  end
  
  #
  # Anonymous Testing
  #
  
  # Test anonymous login
  def test_anonymous_login
    #puts "API Key: #{@api_key}"
    session = Session.new(@api_key)
    assert(session.login_anonymously, "Anonymous Login Failed")
  end
  
  # Test that we can get a listing of albums anonymously. 
  def test_anonymous_album_listing
    session = Session.new(@api_key)
    login = session.login_anonymously
    #puts login.inspect
    assert(Albums.get(session, {:NickName => @nickname}), "Anonymous Album listing failed.")
  end
  
  # Test that we can get a listing of images in an album anonymously.
  # List all images in the first public album we can see.
  def test_anonymous_image_listing
    session = Session.new(@api_key)
    login = session.login_anonymously
    #puts "Session Info: #{session.inspect}"
    #puts "Login Info: #{session.inspect}"
    albums = Albums.get(session, {:NickName => @nickname})
    #puts "Album Info: #{albums.inspect}"
    #puts "First Album Info: #{albums[0].inspect}"
    #images = Images.get(session, albums[0])
    #puts "Image Array: #{images.inspect}"
    assert(Images.get(session, albums[0]), "Anonymous Image listing from first album failed.")
  end
  
  # Test getting a specific image from a specific album.
  # For this test we use the first publich album and pull the
  # first image from the album.  Use the Heavy attribute 
  # to request more information.
  def test_anonymous_image_retrieval_heavy
    session = Session.new(@api_key)
    login = session.login_anonymously
    albums = Albums.get(session, {:NickName => @nickname})
    images = Images.get(session, albums[0], {:Heavy => 1})
    #puts "Images: #{images.inspect}"
    #puts "Images: #{images[0].attributes["small_url"]}"
    assert(images[0].attributes["small_url"], "Anonymous image retrieval failed. No small URL")
  end
  
  # Test getting a specific image attribute from an image.
  # Attempt to the the small_url attribute.
  def test_anonymous_image_retrieval_extras
    session = Session.new(@api_key)
    login = session.login_anonymously
    albums = Albums.get(session, {:NickName => @nickname})
    images = Images.get(session, albums[0], {:Extras => "SmallURL"})
    #puts "Images: #{images.inspect}"
    #puts "Images: #{images[0].attributes["small_url"]}"
    assert(images[0].attributes["small_url"], "Anonymous image retrieval with extras failed. No small URL")
  end
  
  # Test getting EXIF information.
  def test_anonymous_image_retrieval_exif
    session = Session.new(@api_key)
    login = session.login_anonymously
    albums = Albums.get(session, {:NickName => @nickname})
    images = Images.get(session, albums[0])
    exif = Images.get_exif(session, images[0])
    puts "Image EXIF: #{exif.inspect}"
    
    #assert(images[0].attributes["small_url"], "Anonymous image retrieval with extras failed. No small URL")
  end
  
  # 
  # User/Password Authenticated Testing
  #
  
  
end

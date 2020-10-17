module ApplicationHelper
  # Use gravatar to get a user profile picture
  #  If a user has signed up with gravatar and uploaded an image with their email
  #  The profile picture they selected in gravatar should be displayed
  def gravatar_for(user, options = {size: 80})
    # format email address to lowercase
    email_address = user.email.downcase
    # Create an MD5 hash with user email
    # Digest provided by yarn probably by default
    hash = Digest::MD5.hexdigest(email_address)
    # Set default size options will use default from above if not specified when method is called
    size = options[:size]
    # Create url for image 
    # Gravatar stores all images at a url with an MD5 hash of the users email with size listed
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    # Return an html image tag with the gravatar url and appropriate classes
    image_tag(gravatar_url, alt: user.username, class: "rounded shadow mx-auto d-block mt-4")
  end

  # returns a bootstrap class based on the type of flash message passed in
  def bootstrap_class_for(flash_type)
    case flash_type
      # for flash[:alert]
      when "alert"
        "alert-danger"
      # for flash[:notice]
      when "notice"
        "alert-success"
      # If flash message type isn't listed above then use the provided type as a string
      # Any flash methods that get caught here should have a custom css class made
      else
        flash_type.to_s
      end
  end
end

module ErrorsHelper
    
  def set_error(message)
    @errors.nil? ? @errors = [message] : @errors << message
  end

end
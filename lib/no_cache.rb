ActionController::Base.class_eval do

protected

  def self.force_no_cache
    before_filter :force_no_cache_filter_method
  end

  def force_no_cache_filter_method
    # set modify date to current timestamp
    response.headers["Last-Modified"] = CGI::rfc1123_date(Time.now)

    # set expiry to back in the past (makes us a bad candidate for caching)
    response.headers["Expires"] = "0"

    # HTTP 1.0 (disable caching)
    response.headers["Pragma"] = "no-cache"

    # HTTP 1.1 (disable caching of any kind)
    # HTTP 1.1 'pre-check=0, post-check=0' => (Internet Explorer should always check)
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate, pre-check=0, post-check=0"
  end
end

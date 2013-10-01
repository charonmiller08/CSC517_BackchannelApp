module SessionsHelper
  def redirect_back_or(default = home_url, notice = '', notice_color= "invalid")
    #self.notice = options[:notice] || ' '
    #self.notice_color = options[:notice_color] || "invalid"
    #self.return_to = options[:return_to] || home_url
    flash[:notice] = notice
    flash[:color] = notice_color
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
    puts "url_back"
    puts session[:return_to]

  end
end

module SessionsHelper
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
    puts "url_back"
    puts session[:return_to]

  end
end

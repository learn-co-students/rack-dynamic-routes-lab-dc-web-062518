require 'pry'

class Application

  def call(env)

    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      a = @@items.find {|i| i.name == item_name}
      if a == nil
        resp.write "Item not found"
        resp.status = 400
      else
        resp.write "#{a.price}"
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end

end

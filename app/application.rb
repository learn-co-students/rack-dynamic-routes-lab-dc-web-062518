require 'pry'
class Application

@@items = []


  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      i_name = req.path.split("/items/").last
      item = @@items.find {|i| i.name == i_name}

      if item == nil
        resp.status = 400
        resp.write "Item not found!"
      elsif item.name == i_name
        resp.write item.price
      end

    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish

  end


end

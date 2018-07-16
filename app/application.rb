require 'pry'
class Application

@@items = []
#Item.new("Figs",3.42),Item.new("Pears",0.99)

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

  #add_item = req.params["item"]
  #    if @@items.include? add_item
  #      @@cart << add_item
  #      resp.write "added #{add_item}"
  #    else
    #    resp.write "We don't have that item!"
  #    end

end

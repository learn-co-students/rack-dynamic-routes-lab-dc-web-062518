require 'pry'
class Application

  @@items = []
  @@cart = []


  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      item = @@items.find{|s| s.name == item_name}
        if item == nil
          resp.write "Item not found"
          resp.status = 400
        else
          resp.write item.price
        end
    # elsif req.path.match(/search/)
    #
    #   search_term = req.params["q"]
    #   resp.write handle_search(search_term)

    # elsif req.path.match(/cart/)
    #     if @@cart.length == 0
    #       resp.write "Your cart is empty"
    #     else
    #       @@cart.each do |item|
    #         resp.write "#{item}\n"
    #       end
    #     end

     elsif req.path.match(/add/)


       search_term = req.params["item"]


         if @@items.include?(search_term)
           @@cart << search_term
           resp.write "added #{search_term}"

         else
           resp.write "Item not found"

         end

     else
          resp.write "Route not found"
          resp.status = 404
      end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

end

module Shop
  class StartsController < ShopController

    # GET /starts
    # GET /starts.json
    def index
      @starts = Start.all
    end

    # GET /starts/1
    # GET /starts/1.json
    def show
    end

  end
end

module Shop
  class EventsController < ShopController

    # GET /events
    # GET /events.json
    def index
      @events = Event.all.list_for(params[:page], params[:tag])
      @archives = Event.all.archive_for(params[:page], params[:tag])
    end

    # GET /events/1
    # GET /events/1.json
    def show
      @event = Event.find(params[:id])
    end
    
  end
end

module Authors
  class TicketsController < AuthorController
    before_action :set_ticket, only: [:show, :edit, :update, :destroy]

    # GET /tickets
    # GET /tickets.json
    def index
      @tickets = current_author.tickets.most_recent
    end

    # GET /tickets/1
    # GET /tickets/1.json
    def show
    end

    # GET /tickets/new
    def new
      @ticket = current_author.Ticket.new
    end

    # GET /tickets/1/edit
    def edit
    end

    # POST /tickets
    # POST /tickets.json
    def create
      # @ticket = current_author.Ticket.new(ticket_params)
      #
      # respond_to do |format|
      #   if @ticket.save
      #     format.html {redirect_to @ticket, notice: 'Ticket was successfully created.'}
      #     format.json {render :show, status: :created, location: @ticket}
      #   else
      #     format.html {render :new}
      #     format.json {render json: @ticket.errors, status: :unprocessable_entity}
      #   end
      # end

      event_id = params[:event_id].to_i
      ticket_counter = params[:ticket_counter].to_i
      author_id = params[:user_id].to_i
      ticket = Ticket.where(event_id: event_id).where(author_id: author_id)[0]

      event = Event.find(event_id)

      if ((I18n.l event.date, :format => "%d-%m-%Y") == Date.current.to_s)
        cost = ticket_counter * (event.price * 1.2)
      else
        cost = ticket_counter * event.price
      end

      current_author.money -= cost
      event.quantity -= ticket_counter

      if ticket != nil
        puts ticket.name
        puts ticket.ticket_counter

        counter = ticket.ticket_counter + ticket_counter
        if (counter) <= 5
          ticket.update(name: event.name, picture_url: event.event_picture_url,
                                                        author_id: author_id, event_id: event_id, ticket_counter: counter)
          ticket.save()
          event.save()
          current_author.save()
          redirect_to authors_tickets_url
        else
          redirect_to events_path, notice: 'Możesz posiadać tylko 5 biletów na to wydarzenie!'
          
        end
      else
        ticket = Ticket.create(name: event.name, picture_url: event.event_picture_url,
                               author_id: author_id, event_id: event_id, ticket_counter: ticket_counter)
        ticket.save()
        event.save()
        current_author.save()
        redirect_to authors_tickets_url
      end
    end

    # PATCH/PUT /tickets/1
    # PATCH/PUT /tickets/1.json
    def update
      respond_to do |format|
        if @ticket.update(ticket_params)
          format.html {redirect_to @ticket, notice: 'Ticket was successfully updated.'}
          format.json {render :show, status: :ok, location: @ticket}
        else
          format.html {render :edit}
          format.json {render json: @ticket.errors, status: :unprocessable_entity}
        end
      end
    end

    # DELETE /tickets/1
    # DELETE /tickets/1.json
    def destroy
      @ticket.destroy
      respond_to do |format|
        format.html {redirect_to tickets_url, notice: 'Ticket was successfully destroyed.'}
        format.json {head :no_content}
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      if params[:id] != 'summary'
        @ticket = Ticket.find(params[:id])
      else
        redirect_to events_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:name, :seat_id_seq, :address, :price, :email_address, :picture_url)
    end
  end
end

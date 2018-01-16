module Authors
  class TicketsController < AuthorController
    before_action :set_ticket, only: [:show, :edit, :update, :destroy]

    # GET /tickets
    # GET /tickets.json
    def index
      @tickets = current_author.tickets.most_recent.paginate(:page => params[:page], per_page: 5)
    end

    def returns
      @returns = Ticket.where(is_return: true)
    end

    def ticket_return
      ticket_id = params[:ticket_id].to_i

      ticket = Ticket.find(ticket_id)
      ticket.is_return = true
      ticket.return_counter += 1
      ticket.ticket_counter -= 1

      ticket.save()

      redirect_to authors_tickets_path
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

        counter = ticket.ticket_counter + ticket_counter
        if (counter) <= 5
          ticket.update(name: event.name, picture_url: event.event_picture_url,
                        author_id: author_id, event_id: event_id, ticket_counter: counter, price: cost, date: event.date)
          ticket.save()
          event.save()
          current_author.save()
          redirect_to authors_tickets_url
        else
          redirect_to events_path, notice: 'Możesz posiadać tylko 5 biletów na to wydarzenie!'

        end
      else
        ticket = Ticket.create(name: event.name, picture_url: event.event_picture_url,
                               author_id: author_id, event_id: event_id, ticket_counter: ticket_counter, price: cost, date: event.date)
        ticket.save()
        event.save()
        current_author.save()
        redirect_to authors_tickets_url
      end
    end

    def return_all
      event_id = params[:event_id].to_i
      event_price = params[:event_id].to_f
      ticket_counter = params[:ticket_counter].to_i
      return_counter = params[:return_counter].to_i
      date = params[:date].to_date
      author_id = params[:author_id].to_i
      author = Author.find(author_id)
      ticket = Ticket.where(event_id: event_id).where(author_id: author_id)[0]

      if ((I18n.l date, :format => "%d-%m-%Y") == Date.current.to_s)
        returns = return_counter * (event_price * 0.2)
      else
        returns = return_counter * (event_price * 0.6)
      end

      author.money += returns
      author.save()

      if ((ticket_counter - return_counter) == 0)
        ticket.destroy
      else
        ticket.ticket_counter = ticket_counter - return_counter
        ticket.return_counter = 0
        ticket.is_return = false
      end

      ticket.save()
      redirect_to authors_returns_path
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

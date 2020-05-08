class Tickets::TicketsController < ApplicationController
  def index
    @pagy, @records = pagy(Ticket.all)
    render 'tickets/index', locals: { tickets: @records } if stale?(@records)
  end

  def show
    @record = Ticket.find(params[:id])
    render 'tickets/show', locals: { ticket: @record } if stale?(@record)
  end
end

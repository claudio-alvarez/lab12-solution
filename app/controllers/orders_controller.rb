class OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /orders
  # GET /orders.json
  def index
    @pagy, @orders = pagy(Order.where(customer: current_customer))
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @items = []
    @total = 0
    begin
      ticket_types_h = @order.tickets.select(:ticket_type_id).group(:ticket_type_id).count
      @total_items = ticket_types_h.values.sum

      ticket_types_m = TicketType.includes(:event).find(ticket_types_h.keys)

      # Traverse keys (ticket type IDs)
      ticket_types_m.each do |tt|
        # Amount of tickets per ticket type
        amount = ticket_types_h[tt.id]
        @items << { ticket_type: tt, amount: amount, total_price: amount*tt.ticket_price }
        @total += amount*tt.ticket_price
      end
      rescue
      # Log the error and redirect back to the referer
        logger.error("[OrdersController#show] Unable to display order items")
        flash[:alert] = "Failed to display shopping order items"
        redirect_back(fallback_location: root_path)
      end
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy

    respond_to do |format|
      format.js { head :no_content }
      format.html { redirect_to order_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.fetch(:order, {})
    end
end

class TurnsController < ApplicationController
  before_action :set_turn, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: :api_create

  # GET /turns
  # GET /turns.json
  def index
    @turns = Turn.all
  end

  # GET /turns/1
  # GET /turns/1.json
  def show
  end

  # GET /turns/new
  def new
    @turn = Turn.new
  end

  # GET /turns/1/edit
  def edit
  end

  # POST /turns
  # POST /turns.json
  def create
    @turn = Turn.new(turn_params)

    respond_to do |format|
      if @turn.save
        format.html { redirect_to @turn, notice: 'Turn was successfully created.' }
        format.json { render :show, status: :created, location: @turn }
      else
        format.html { render :new }
        format.json { render json: @turn.errors, status: :unprocessable_entity }
      end
    end
  end

  def api_create
    turn = Turn.new(turn_params)
    if turn.save
      render json: { code: turn.get_code, cc: turn.cc }
    else
      render json: turn.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /turns/1
  # PATCH/PUT /turns/1.json
  def update
    respond_to do |format|
      if @turn.update(turn_params)
        @turn.consulting_room.turns.attending.map{ |t| t.finalize! } if @turn.consulting_room
        @turn.called!
        format.html { redirect_to @turn, notice: 'Turn was successfully updated.' }
        format.json { render :show, status: :ok, location: @turn }
      else
        format.html { render :edit }
        format.json { render json: @turn.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /turns/1
  # DELETE /turns/1.json
  def destroy
    @turn.destroy
    respond_to do |format|
      format.html { redirect_to turns_url, notice: 'Turn was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def current_turns
    render json: { data: Turn.all.attending.includes(:consulting_room).map{ |t| { id: t.consulting_room.id, name: t.consulting_room.name, code: t.get_code } } }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_turn
      @turn = Turn.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def turn_params
      params.require(:turn).permit(:code, :specialty, :cc, :consulting_room_id)
    end
end

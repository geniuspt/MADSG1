class StatesController < ApplicationController

#Funtion that returns all states in the data base
#
# * *Returns* :
#   - all states
#
  # GET /states
  # GET /states.json
  def index
    @states = State.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @states }
    end
  end
  
  def get_last_state(id)
    State.select("body").where("page_id = ?",id).order("updated_at DESC").first
  end
  
  
#Funtion that renders a visualization of a state, showing its body, date of creation and author
#
# * *Args*    :
#   - +id+ -> state identification
# * *Returns* :
#   - state, body, date of creation and author
#
  # GET /states/1
  # GET /states/1.json
  def show
    @state = State.where("states.id = ?",params[:id]).joins(:user).select("states.*, users.name AS name").first
    @page = Page.find(@state.page_id)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @state }
    end
  end

#Funtion to create a form for state creation
#
# * *Returns* :
#   - renders a form to create a state
#
  # GET /states/new
  # GET /states/new.json
  def new
    @state = State.new
	@user_name = request.remote_ip
	@page_id = params[:id]
	
	@user = User.where("name LIKE ?",@user_name)
	
	if @user.empty?
		@user = User.new(:name => @user_name)
		@user.save
	else
		@user = 	@user.first
	end
	@state.page_id = @page_id
	@state.user_id = @user.id
	
	@state_temp = get_last_state(@page_id)
	if not @state_temp.nil?
		@state.body = @state_temp.body
	end
	
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @state }
    end
  end

#Funtion to edit a state
#
# * *Args*    :
#   - +id+ -> state identification
# * *Returns* :
#   - edited state
#
  # GET /states/1/edit
  def edit
    @state = State.find(params[:id])
  end

#Funtion to create a new state
#
# * *Returns* :
#   - new state
# * *Raises* :
#   - +Error+ -> if action of creating state fails
#
  # POST /states
  # POST /states.json
  def create
    @state = State.new(params[:state])
	
	
    respond_to do |format|
      if @state.save
      	@page = Page.find(@state.page_id);
        format.html { redirect_to @page, notice: 'State was successfully created.' }
        format.json { render json: @state, status: :created, location: @state }
      else
        format.html { render action: "new" }
        format.json { render json: @state.errors, status: :unprocessable_entity }
      end
    end
  end

#Funtion to update a state
#
# * *Args*    :
#   - +id+ -> state identification
# * *Returns* :
#   - renders action to edit a state
# * *Raises* :
#   - +Error+ -> if action of editing state fails
#
  # PUT /states/1
  # PUT /states/1.json
  def update
    @state = State.find(params[:id])

    respond_to do |format|
      if @state.update_attributes(params[:state])
        format.html { redirect_to @state, notice: 'State was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @state.errors, status: :unprocessable_entity }
      end
    end
  end

#Funtion to delete a state
#
# * *Args*    :
#   - +id+ -> page identification
#
  # DELETE /states/1
  # DELETE /states/1.json
  def destroy
    @state = State.find(params[:id])
    @state.destroy

    respond_to do |format|
      format.html { redirect_to states_url }
      format.json { head :ok }
    end
  end
end

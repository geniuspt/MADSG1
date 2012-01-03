class UsersController < ApplicationController

#Funtion that retrieves all comments made by a user
#
# * *Args*    :
#   - +id+ -> user identification
# * *Returns* :
#   - comments made the given user 
#  
   def get_related_comments
    @comments = Comment.where("user_id=?",params[:id])

    respond_to do |format|
      format.html # get_related_comments.html.erb
      format.json { render json: @users }
    end
  end
  
#Funtion that retrieves all page states made by a user
#
# * *Args*    :
#   - +id+ -> user identification
# * *Returns* :
#   - states made by the given user
#
  def get_related_states
    @states = State.where("user_id=?",params[:id])

    respond_to do |format|
      format.html # get_related_state.html.erb
      format.json { render json: @users }
    end
  end
  
#Funtion that returns all users in the data base
#
# * *Returns* :
#   - all users
#
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

#Funtion that renders a visualization of a user, showing its internet protocol (IP) address
#
# * *Args*    :
#   - +id+ -> user identification
# * *Returns* :
#   - user
#
  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

#Funtion to create a form for user creation
#
# * *Returns* :
#   - renders a form to create a user
#
  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

#Funtion to edit a user
#
# * *Args*    :
#   - +id+ -> user identification
# * *Returns* :
#   - edited user
#
  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

#Funtion to create a new user
#
# * *Returns* :
#   - new user
# * *Raises* :
#   - +Error+ -> if action of creating user fails
#
  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

#Funtion to update a user
#
# * *Args*    :
#   - +id+ -> user identification
# * *Returns* :
#   - renders action to edit a user
# * *Raises* :
#   - +Error+ -> if action of editing user fails
#
  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

#Funtion to delete a user
#
# * *Args*    :
#   - +id+ -> user identification
#
  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end
end

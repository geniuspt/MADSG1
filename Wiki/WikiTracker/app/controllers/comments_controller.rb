class CommentsController < ApplicationController

#Funtion that returns all comments in the data base
#
# * *Returns* :
#   - all comments
#
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

#Funtion that renders a visualization of a comment, showing its body and author
#
# * *Args*    :
#   - +id+ -> comment identification
# * *Returns* :
#   - comment, body and author
#
  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

#Funtion to create a form for comment creation
#
# * *Returns* :
#   - renders a form to create a comment
#
  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new
	@user_name = request.remote_ip
	@page_id = params[:id]
	
	@user = User.where("name LIKE ?",@user_name)
	
	if @user.empty?
		@user = User.new(:name => @user_name)
		@user.save
	else
		@user = 	@user.first
	end
	@comment.page_id = @page_id
	@comment.user_id = @user.id
	
	respond_to do |format|
	  format.html # new.html.erb
	  format.json { render json: @comment }
	end
	
  end

#Funtion to edit a comment
#
# * *Args*    :
#   - +id+ -> comment identification
# * *Returns* :
#   - edited comment
#
  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

#Funtion to create a new comment
#
# * *Returns* :
#   - new comment
# * *Raises* :
#   - +Error+ -> if action of creating comment fails
#
  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(params[:comment])
    
    respond_to do |format|
      if @comment.save
      	@page = Page.find(@comment.page_id)
        format.html { redirect_to @page , notice: 'Comment was successfully updated.'}
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

#Funtion to update a comment
#
# * *Args*    :
#   - +id+ -> comment identification
# * *Returns* :
#   - renders action to edit a comment
# * *Raises* :
#   - +Error+ -> if action of editing comment fails
#
  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

#Funtion to delete a comment
#
# * *Args*    :
#   - +id+ -> comment identification
#
  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :ok }
    end
  end
  
#Funtion that retrieves all comments associated to a page
#
# * *Args*    :
#   - +id+ -> page identification
# * *Returns* :
#   - comments of a page
#
  def get_by_page
    @comments = Comment.where("page_id = ?",params[:id])
  
    respond_to do |format|
      format.html # get_by_page.html.erb
      format.json { render json: @comments }
    end
  end
end

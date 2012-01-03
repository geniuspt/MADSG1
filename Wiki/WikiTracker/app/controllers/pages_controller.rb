class PagesController < ApplicationController

#Funtion that retreives all comments made to the given page
#
# * *Args*    :
#   - +id+ -> page identification
# * *Returns* :
#   - comments associated to the given page
#
def get_related_comments
  
    @comments = Comment.where("page_id = ?",params[:id]).select("comments.*, users.name AS name").joins(:user)
	@page_id = params[:id]
	#@page = Page.find(params[:id])
    respond_to do |format|
      format.html # get_related_comments.html.erb
      format.json { render json: @pages }
    end
  end
 
#Funtion to retrive the content of the current version of a page
#
# * *Args*    :
#   - +id+ -> project identification
# * *Returns* :
#   - most recent state of a page
# 
  def get_last_state(id)
    State.where("page_id = ?",id).order("updated_at DESC").first
  end

#Funtion to retrieve all states of a page
#
# * *Args*    :
#   - +id+ -> project identification
# * *Returns* :
#   - states of a page
#  
  def get_related_states
	@states = State.where("page_id = ?",params[:id]).joins(:user).select("states.*, users.name AS name").order("updated_at DESC")
	@page_id = params[:id]
	
	@page = Page.find(@page_id)
	respond_to do |format|
      format.html # get_related_states.html.erb
      format.json { render json: @states }
	end
  end

#Funtion that returns all pages in the data base
#
# * *Returns* :
#   - all pages
#
  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end

#Funtion that renders a visualization of a pages, showing its most recent content
#
# * *Args*    :
#   - +id+ -> page identification
# * *Returns* :
#   - content of a page, title and most recent body
#
  # GET /pages/1
  # GET /pages/1.json
  def show
    @page = Page.find(params[:id])
	@state= get_last_state(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

#Funtion to create a form for page creation
#
# * *Returns* :
#   - renders a form to create a page
#
  # GET /pages/new
  # GET /pages/new.json
  def new
    @page = Page.new
	@page.project_id = params[:id]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page }
    end
  end

#Funtion to edit a page
#
# * *Args*    :
#   - +id+ -> page identification
# * *Returns* :
#   - edited page
#
  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
  end

#Funtion to create a new page
#
# * *Returns* :
#   - new page
# * *Raises* :
#   - +Error+ -> if action of creating page fails
#
  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

#Funtion to update a page
#
# * *Args*    :
#   - +id+ -> page identification
# * *Returns* :
#   - renders action to edit a page
# * *Raises* :
#   - +Error+ -> if action of editing page fails
#
  # PUT /pages/1
  # PUT /pages/1.json
  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end
  

#Funtion to delete a page
#
# * *Args*    :
#   - +id+ -> page identification
#
  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :ok }
    end
  end
end

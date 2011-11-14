class PagesController < ApplicationController


def get_related_comments
  
    @comments = Comment.where("page_id = ?",params[:id]).select("comments.*, users.name AS name").joins(:user)
	@page_id = params[:id]
	#@page = Page.find(params[:id])
    respond_to do |format|
      format.html # get_related_comments.html.erb
      format.json { render json: @pages }
    end
  end
  
  def get_last_state
  
    @page = State.select("body").where("page_id = ?",params[:id]).order("updated_at DESC").first
	#@page = Page.find(params[:id])
    respond_to do |format|
      format.html # get_last_state.html.erb
      format.json { render json: @pages }
    end
  end

  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    @page = Page.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

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

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
  end

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
  
  def get_related_states
	@states = State.where("page_id = ?",params[:id])

	respond_to do |format|
      format.html # get_related_states.html.erb
      format.json { render json: @states }
	end
  end

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

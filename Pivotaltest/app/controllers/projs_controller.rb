class ProjsController < ApplicationController
  # GET /projs
  # GET /projs.json
  def index
    @projs = Proj.all
    my_project = TrackR::Project.new(:project_id => '376079', :token => 'acf137d24a05ced3234a15af43ceb3db')
    
    story = my_project.story(19184509)
    
    render json: my_project.stories
    #render json: story.name
    #t = TrackR::Token.new(:username => 'tiagodloureiro@gmail.com', :password => 'pudente123')
   # render t
    #respond_to do |format|
     # format.html # index.html.erb
      #format.json { render json: @projs }
    #end
  end

  # GET /projs/1
  # GET /projs/1.json
  def show
    @proj = Proj.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @proj }
    end
  end

  # GET /projs/new
  # GET /projs/new.json
  def new
    @proj = Proj.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @proj }
    end
  end

  # GET /projs/1/edit
  def edit
    @proj = Proj.find(params[:id])
  end

  # POST /projs
  # POST /projs.json
  def create
    @proj = Proj.new(params[:proj])

    respond_to do |format|
      if @proj.save
        format.html { redirect_to @proj, notice: 'Proj was successfully created.' }
        format.json { render json: @proj, status: :created, location: @proj }
      else
        format.html { render action: "new" }
        format.json { render json: @proj.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projs/1
  # PUT /projs/1.json
  def update
    @proj = Proj.find(params[:id])

    respond_to do |format|
      if @proj.update_attributes(params[:proj])
        format.html { redirect_to @proj, notice: 'Proj was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @proj.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projs/1
  # DELETE /projs/1.json
  def destroy
    @proj = Proj.find(params[:id])
    @proj.destroy

    respond_to do |format|
      format.html { redirect_to projs_url }
      format.json { head :ok }
    end
  end
end

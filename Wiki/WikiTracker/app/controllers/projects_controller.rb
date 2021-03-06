class ProjectsController < ApplicationController

#Funtion that returns the pages related to a project
#
# * *Args*    :
#   - +id+ -> project identification
# * *Returns* :
#   - pages associated with the given project
#
  def get_related_pages
    @pages = Page.where("project_id=?",params[:id])
    @project_id = params[:id]
    
    respond_to do |format|
      format.html  # get_related_pages.html.erb
      format.json { render json: @projects }
    end
  end

#Funtion that returns all projects in the data base
#
# * *Returns* :
#   - all projects
#
  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

#Funtion that renders a visualization of all pages associated with a project
#
# * *Args*    :
#   - +id+ -> project identification
# * *Returns* :
#   - pages associated with the given project
#
  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    Project.getAllStoriesFromPivotal(params[:id])	
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @projects }
    end
    
  end

#Funtion to create a form for project creation
#
# * *Returns* :
#   - renders a form to create a project
#
  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

#Funtion to edit a project
#
# * *Args*    :
#   - +id+ -> project identification
# * *Returns* :
#   - edited project
#
  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

#Funtion to create a new project
#
# * *Returns* :
#   - new project associated with a pivotal tracker account
# * *Raises* :
#   - +Error+ -> if action of creating project fails
#
  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])
    @project.pivotal_token = PivotalTracker::Client.token(@project.pivotal_user, @project.pivotal_pass)
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

#Funtion to update a project
#
# * *Args*    :
#   - +id+ -> project identification
# * *Returns* :
#   - renders action to edit a project
# * *Raises* :
#   - +Error+ -> if action of editing project fails
#
  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

#Funtion to delete a project
#
# * *Args*    :
#   - +id+ -> project identification
#
  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :ok }
    end
  end
end

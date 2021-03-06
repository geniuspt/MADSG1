class UserStoriesController < ApplicationController 
  # GET /user_stories
  # GET /user_stories.json
  def getByProject
    @user_stories = UserStory.where("project_id = ?",params[:id])
    @project = Project.find(:first, :conditions => [ "pivotal_id = ? ",params[:id]])	
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_stories }
    end
  end

  
  # GET /user_stories/1
  # GET /user_stories/1.json
  def show
    @user_story = UserStory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_story }
    end
  end

  # GET /user_stories/new
  # GET /user_stories/new.json
  def new
    @user_story = UserStory.new
    @user_story.project_id = params[:id]
    @memberships = Membership.all
   	
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_story }
    end
  end

  # GET /user_stories/1/edit
  def edit
    @user_story = UserStory.find(params[:id])
    @memberships = Membership.all
  end

  # POST /user_stories
  # POST /user_stories.json
  def create
    @user_story = UserStory.new(params[:user_story])
    aux = UserStory.addStory(@user_story)
    if(aux.id == nil)	    
	 render json: aux.errors
    else
	@user_story.id_pivotal = aux.id
	respond_to do |format|
		if @user_story.save
		   format.html { redirect_to @user_story, notice: 'User story was successfully created.' }
		   format.json { render json: @user_story, status: :created, location: @user_story }
		else
		   @memberships = Membership.all
		   format.html { render action: "new" }
		   format.json { render json: @user_story.errors, status: :unprocessable_entity }
		end
	end
    end		
  end

  # PUT /user_stories/1
  # PUT /user_stories/1.json
  def update
    @user_story = UserStory.find(params[:id])


    respond_to do |format|
      if @user_story.update_attributes(params[:user_story])
	UserStory.editStory(@user_story)
        format.html { redirect_to @user_story, notice: 'User story was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_stories/1
  # DELETE /user_stories/1.json
  def destroy
    @user_story = UserStory.find(params[:id])
    @project = Project.find(:first, :conditions => [ "pivotal_id = ? ",@user_story.project_id])	
    PivotalTracker::Client.token = @project.pivotal_token 
    @a_project = PivotalTracker::Project.find(@project.pivotal_id) 
    @qq =  @a_project.stories.find(@user_story.id_pivotal)
    @qq.delete
    @user_story.destroy
	
    respond_to do |format|
      format.html { redirect_to :controller => "user_stories", :action => "getByProject", :id => @project.pivotal_id }
      format.json { head :ok }
    end
  end
end

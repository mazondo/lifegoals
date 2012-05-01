class TodosController < ApplicationController
  before_filter :grab_goal
  # GET /todos
  # GET /todos.json
  def index
    @todos = @goal.todos.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @todos }
    end
  end

  # GET /todos/1
  # GET /todos/1.json
  def show
    @todo = @goal.todos.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @todo }
    end
  end

  # GET /todos/new
  # GET /todos/new.json
  def new
    @todo = @goal.todos.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @todo }
    end
  end

  # GET /todos/1/edit
  def edit
    @todo = @goal.todos.find(params[:id])
  end

  # POST /todos
  # POST /todos.json
  def create
    @todo = @goal.todos.new(params[:todo])

    respond_to do |format|
      if @todo.save
        format.html { redirect_to @goal, notice: 'Todo was successfully created.' }
        format.json { render json: @todo, status: :created, location: @todo }
      else
        format.html { render action: "new" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /todos/1
  # PUT /todos/1.json
  def update
    @todo = @goal.todos.find(params[:id])

    respond_to do |format|
      if @todo.update_attributes(params[:todo])
        format.html { redirect_to @goal, notice: 'Todo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo = @goal.todos.find(params[:id])
    @todo.destroy

    respond_to do |format|
      format.html { redirect_to @goal }
      format.json { head :no_content }
    end
  end
  
  private
  
  def grab_goal
    @goal = Goal.find(params[:goal_id])
  end
end

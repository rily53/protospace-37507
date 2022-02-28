class PrototypesController < ApplicationController
  # before_action :move_to_index, except: [:index, :show]
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  #before_action :contributor_confirmation, only: [:edit, :update, :destroy]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    # @prototype.user_id = current_user.id
    if @prototype.save
      redirect_to root_path
    else
      # @prototype = Prototype.new(prototype_params)
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments
  end

  def edit
    @prototype = Prototype.find(params[:id])
    unless user_signed_in? && current_user.id == @prototype.user_id
      redirect_to action: :index
    end
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path
    else
      render :edit
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end

  # def move_to_index
  #  unless user_signd_in?
  #    redirect_to action: :index
  #  end
  # end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

end

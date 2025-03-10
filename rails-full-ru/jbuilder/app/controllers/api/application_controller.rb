# frozen_string_literal: true

class Api::ApplicationController < ApplicationController
  def index
    @users = User.all

    respond_to do |format|
      format.json { render json: @users, each_serializer: UserSerializer }
    end
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.json { render json: @user, serializer: UserSerializer }
    end
  end
end

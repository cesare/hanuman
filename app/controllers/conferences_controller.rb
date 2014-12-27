class ConferencesController < ApplicationController
  def index
    @conferences = Conference.published.all
  end

  def show
    @conference = Conference.published.find params[:id]
  end
end

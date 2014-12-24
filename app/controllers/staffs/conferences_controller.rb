module Staffs
  class ConferencesController < ApplicationController
    before_action :authenticate_person!
    before_action :load_conference

    def show
    end

    def edit
    end

    def update
      if @conference.update conference_updating_params
        redirect_to staff_conference_path(@conference)
      else
        render :edit
      end
    end

    private

    def load_conference
      @conference = current_person.running_conferences.find params[:id]
    end

    def conference_updating_params
      params
        .require(:conference)
        .permit(:name, :description, :published, :begins_at, :ends_at, :proposal_deadline)
    end
  end
end

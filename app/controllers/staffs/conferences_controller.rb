module Staffs
  class ConferencesController < ApplicationController
    before_action :authenticate_person!
    before_action :load_conference

    def show
    end

    private

    def load_conference
      @conference = current_person.running_conferences.find params[:id]
    end
  end
end

module Conferences
  class ProposalsController < ApplicationController
    before_action :authenticate_person!
    before_action :load_conference

    def show
      @proposal = @conference.proposals.find_by! person: current_person, id: params[:id]
    end

    def new
      @proposal = @conference.proposals.build(person: current_person)
    end

    def create
      @proposal = @conference.proposals.build proposal_registration_params
      if @proposal.valid?
        @proposal.save!
        redirect_to conference_proposal_path(@conference, @proposal)
      else
        render action: :new, status: :unprocessable_entity
      end
    end

    private

    def load_conference
      @conference = Conference.find(params[:conference_id])
    end

    def proposal_registration_params
      params.require(:proposal).permit(:title, :summary).merge(person: current_person)
    end
  end
end

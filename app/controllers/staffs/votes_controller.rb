module Staffs
  class VotesController < ApplicationController
    before_action :authenticate_person!
    before_action :load_conference
    before_action :load_proposal, only: %i(destroy)
    before_action :load_vote, only: %i(destroy)

    def create
      current_person.votes.create vote_params

      redirect_to staff_conference_path @conference
    end

    def destroy
      @vote.destroy

      redirect_to staff_conference_path @conference
    end

    private

    def load_conference
      @conference = current_person.running_conferences.find(params[:conference_id])
    end

    def load_proposal
      @proposal = @conference.proposals.find params[:id]
    end

    def load_vote
      @vote = current_person.votes.find_by! proposal: @proposal
    end

    def vote_params
      params.require(:vote).permit(:proposal_id)
    end
  end
end

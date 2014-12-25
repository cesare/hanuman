module Staffs
  class ProposalsController < ApplicationController
    before_action :authenticate_person!
    before_action :load_conference

    def index
      @proposals = @conference.proposals.with_person
      @votes_by_person = current_person.votes.where(proposal_id: @proposals.map(&:id))
    end

    def show
      @proposal = @conference.proposals.find params[:id]
    end

    private

    def load_conference
      @conference = current_person.running_conferences.find(params[:conference_id])
    end
  end
end

module Conferences
  class ProposalsController < ApplicationController
    before_action :authenticate_person!
    before_action :load_conference
    before_action :check_deadline, only: %i(new create edit update destroy)
    before_action :load_proposal, only: %i(show edit update destroy)

    def show
    end

    def new
      @proposal = @conference.proposals.build(person: current_person)
    end

    def create
      @proposal = @conference.proposals.build proposal_params
      if @proposal.valid?
        @proposal.save!
        redirect_to conference_proposal_path(@conference, @proposal)
      else
        render action: :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @proposal.update proposal_params
        redirect_to conference_proposal_path(@conference, @proposal)
      else
        render action: :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @proposal.destroy
      redirect_to conference_path @conference
    end

    private

    def load_conference
      @conference = Conference.published.find(params[:conference_id])
    end

    def proposal_params
      params.require(:proposal).permit(:title, :summary).merge(person: current_person)
    end

    def check_deadline
      return if @conference.open_to_proposals?

      redirect_to conference_path(@conference)
    end

    def load_proposal
      @proposal = @conference.proposals.find_by! person: current_person, id: params[:id]
    end
  end
end

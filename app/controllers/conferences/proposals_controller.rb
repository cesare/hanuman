module Conferences
  class ProposalsController < ApplicationController
    before_action :authenticate_person!
    before_action :load_conference
    before_action :require_staff, only: %i(index)
    before_action :check_deadline, only: %i(new create)

    def index
      @proposals = @conference.proposals.with_person
    end

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

    def check_deadline
      return if @conference.open_to_proposals?

      redirect_to conference_path(@conference)
    end

    def require_staff
      @staff = current_person.staffs.find_by(conference: @conference)
      return if @staff

      render_not_found
    end
  end
end

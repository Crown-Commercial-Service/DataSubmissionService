class ReleaseNotesController < ApplicationController
  def index
    @release_notes = API::ReleaseNote.all
    @release_note = params[:id] ? API::ReleaseNote.find(params[:id]).first : @release_notes.first
  end
end

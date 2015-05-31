class CustomResponseScoreRecordsController < ApplicationController
  def index
    @custom_response_score_records = CustomResponseScoreRecord.all
  end

  def show
    @custom_response_score_record = CustomResponseScoreRecord.find(319000)
  end

  def new
  end

  def edit
  end

  def delete
  end
end

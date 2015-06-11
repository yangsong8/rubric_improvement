class ResponseScoreRecordsController < ApplicationController
  def index
    test
  end

  def show
  end

  def new
  end

  def edit
  end

  def delete
  end

  def test
    @response_score_record = ResponseScoreRecord.find(318999).word_count
  end
end

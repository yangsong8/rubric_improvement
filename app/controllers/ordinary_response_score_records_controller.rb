class OrdinaryResponseScoreRecordsController < ApplicationController
  def index
    @ordinary_response_score_records = OrdinaryResponseScoreRecord.all
    #@ordinary_response_score_records.each do |item|
    #  word_count = words_counted(item.comments)
    #  item.update_attribute('word_count', word_count)
    #end
  end

  def show
    @ordinary_response_score_record = OrdinaryResponseScoreRecord.find(325386)
    @word_count = words_counted(@ordinary_response_score_record.comments)
  end

  def new
  end

  def edit
  end

  def delete
  end

  def words_counted(str)
    counter = WordsCounted.count(str)
    return counter.word_count
  end
end

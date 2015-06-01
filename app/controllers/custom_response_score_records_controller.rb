class CustomResponseScoreRecordsController < ApplicationController
  def index
    @custom_response_score_records = CustomResponseScoreRecord.all
    #@custom_response_score_records.each do |item|
    #  word_count = words_counted(item.comments)
    #  item.update_attribute('word_count', word_count)
    #end
    @questions = Question.all
    @questions.each do |q|
      word_count = words_counted(q.txt)
      q.update_attribute('word_count', word_count)
    end
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

  def words_counted(str)
    counter = WordsCounted.count(str)
    return counter.word_count
  end
end

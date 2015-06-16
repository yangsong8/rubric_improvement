class ResponseScoreRecordsController < ApplicationController
  require 'statsample'
  def index
    median_grades_of_each_artifact_and_each_question
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
    x=[1,2,4,9]
    y=[2,4,8,6]
    @response_score_record1 = pearson(x,y)
    @response_score_record2 = spearman(x,y)
  end

  def pearson(x,y)
    pearson = Statsample::Bivariate::Pearson.new(x.to_scale,y.to_scale)
    pearson.r
  end

  def spearman(v1,v2)
    v1a,v2a=Statsample.only_valid_clone(v1.to_scale,v2.to_scale)
    v1r,v2r=v1a.ranked(:scale),v2a.ranked(:scale)
    pearson(v1r,v2r)
  end

  def median_grades_of_each_artifact_and_each_question
    #find distinct reviewee team records
    iterator = 0
    distinct_reviewee_team_records = ResponseScoreRecord.select(:reviewee_team_id).distinct
    distinct_reviewee_team_records.each do |distinct_reviewee_team_record|
      question_ids = Array.new
      #find all question in one reviewee team records
      all_questions_in_one_reviewee_team_record = ResponseScoreRecord.where(reviewee_team_id: distinct_reviewee_team_record.reviewee_team_id)
      all_questions_in_one_reviewee_team_record.each do |one_questions_in_one_reviewee_team_record|
        question_ids << one_questions_in_one_reviewee_team_record.question_id
      end
      #get unique question ids in one reviewee team id
      question_ids.uniq!
      question_ids.each do |question_id|
        specific_records_for_question_id_and_team_id = ResponseScoreRecord.where(reviewee_team_id: distinct_reviewee_team_record.reviewee_team_id, question_id: question_id)
        temp_array = Array.new
        specific_records_for_question_id_and_team_id.each do |specific_record|
          temp_array << specific_record.score.to_i
        end
        median = median(temp_array)
        iterator += 1
        MedianGrade.create(id: iterator, team_id: distinct_reviewee_team_record.reviewee_team_id, question_id: question_id, median: median)  
      end 
    end
    #questions = ResponseScoreRecord.select(:question_id)
  end

  def median(array)
    print array
    puts '========================================='
    return -1 if array.uniq[0]==nil
    sorted = array.sort
    len = sorted.length
    return (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
  end
end

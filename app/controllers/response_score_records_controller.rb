class ResponseScoreRecordsController < ApplicationController
  require 'statsample'
  def index
    #median_grades_of_each_artifact_and_each_question
    #add_liberal_agreement_and_conservative_agreement_to_question_qualities_by_teams
    #calculate_pearson_and_spearman_value_between_each_response_score_and_median_score_of_questionnaire
    average_pearson_and_spearman_value
    #test
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
    @response_score_record3 =cronbach_alpha(x,y)
  end

  def cronbach_alpha(x,y)
    x1=x.to_vector(:scale)
    x2=y.to_vector(:scale)
    ds={'x1'=>x1,'x2'=>x2}.to_dataset
     Statsample::Reliability.cronbach_alpha(ds)
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
      #reject question_ids whose score is null
      question_ids.reject!{|id| ResponseScoreRecord.where(question_id: id).first.score == nil}
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

  def add_liberal_agreement_and_conservative_agreement_to_question_qualities_by_teams
    iterator = 0 
    median_grades = MedianGrade.all
    median_grades.each do |median_grade|
      response_score_records = ResponseScoreRecord.where(reviewee_team_id: median_grade.team_id, question_id: median_grade.question_id)
      temp_array = Array.new
      response_score_records.each do |response_score_record|
          temp_array << response_score_record.score.to_i
      end
      median = median_grade.median.round
      liberal_agreement_num = 0
      conservative_agreement_num = 0
      temp_array.each do |item|
        liberal_agreement_num +=1 if item >= median-1 and item <= median+1
        conservative_agreement_num +=1 if item == median
      end 
      iterator += 1
      question_id = median_grade.question_id
      team_id = median_grade.team_id
      assignment_id = RevieweeTeam.find(team_id).assignment_id
      rated_times = temp_array.size
      liberal_agreement_percentage = (liberal_agreement_num * 1.0 / rated_times).round(4)
      conservative_agreement_percentage = (conservative_agreement_num * 1.0 / rated_times).round(4)
      #print
      print temp_array
      print median
      puts '========================================='
      QuestionQualitiesByTeam.create(id: iterator, assignment_id: assignment_id, question_id: question_id, team_id: team_id, liberal_agreement_num: liberal_agreement_num, conservative_agreement_num: conservative_agreement_num, rated_times: rated_times, liberal_agreement_percentage: liberal_agreement_percentage, conservative_agreement_percentage: conservative_agreement_percentage)
    end
  end

  def calculate_pearson_and_spearman_value_between_each_response_score_and_median_score_of_questionnaire
    iterator = 0
    teams = MedianGrade.select(:team_id).distinct
    teams.each do |team|
      median_grades = MedianGrade.where(team_id: team.team_id).order(:question_id)
      median_vector = Array.new
      #median_score_of_questionnaire
      median_grades.each do |median_grade|
        median_vector << median_grade.median.to_i
      end
      next if median_vector.uniq.size == 1
      responses = ResponseScoreRecord.where(reviewee_team_id: team.team_id).select(:response_id).distinct
      responses.each do |response|
        response_id = response.response_id
        response_score_records = ResponseScoreRecord.where(reviewee_team_id: team.team_id, response_id: response_id).order(:question_id)
        current_response_vector = Array.new
        response_score_records.each do |response_score_record|
          next if response_score_record.score == nil
          current_response_vector << response_score_record.score.to_i
        end
        puts '+++++++++++++++++++++++++++++++++++++++'
        puts current_response_vector.size
        puts median_vector.size
        #median_vector[0] += 0.0001 if median_vector.uniq.size == 1
        #current_response_vector[0] += 0.001 if current_response_vector == 1
        next if current_response_vector.uniq.size == 1
        iterator += 1
        pearson = pearson(median_vector, current_response_vector)
        spearman = spearman(median_vector, current_response_vector)
        
        question_id = median_grades.first.question_id
        questionnaire_id = Question.find(question_id).questionnaire_id
        assignment_id = RevieweeTeam.find(team.team_id).assignment_id
        QuestionnaireQualitiesByResponse.create(id: iterator, questionnaire_id: questionnaire_id, assignment_id: assignment_id, team_id: team.team_id, response_id: response_id, pearson: pearson, spearman: spearman)
      end  
    end
  end

  def average_pearson_and_spearman_value
    iterator = 0
    teams = QuestionnaireQualitiesByResponse.select(:team_id).distinct
    teams.each do |team|
      response_score_records = QuestionnaireQualitiesByResponse.where(team_id: team.team_id)
      rated_times = response_score_records.count
      pearson_sum = 0
      spearman_sum = 0
      response_score_records.each do |response_score_record|
        pearson_sum += response_score_record.pearson
        spearman_sum += response_score_record.spearman
      end
      avg_pearson = (pearson_sum * 1.0 / rated_times).round(4)
      avg_spearman = (spearman_sum * 1.0 / rated_times).round(4)
      iterator += 1
      questionnaire_id = response_score_records.first.questionnaire_id
      assignment_id = response_score_records.first.assignment_id
      QuestionnaireQualitiesByTeam.create(id: iterator, questionnaire_id: questionnaire_id, assignment_id: assignment_id, team_id: team.team_id, rated_times: rated_times, avg_pearson: avg_pearson, avg_spearman: avg_spearman)
    end  
  end
end

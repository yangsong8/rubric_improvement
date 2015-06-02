class OrdinaryResponseScoreRecordsController < ApplicationController
  def index
    @ordinary_response_score_records = OrdinaryResponseScoreRecord.all
    #@ordinary_response_score_records.each do |item|
    #  word_count = words_counted(item.comments)
    #  item.update_attribute('word_count', word_count)
    #end
    #whole_response_words_counted
    #all_questions_average_words_counted
    all_questions_comments_not_null_percentage
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

  def whole_response_words_counted
    @responses = Response.all
    @responses.each do |response|
      word_count = 0
      @ordinary_records = OrdinaryResponseScoreRecord.where(response_id: response.id)
      @ordinary_records.each do |ordinary_record|
        word_count += words_counted(ordinary_record.comments)
      end
      response.update_attribute('word_count', word_count) 
    end
  end

  def all_questions_average_words_counted
    @iterate = 0
    @questionnaires = Questionnaire.all
    @assignment_ids = OrdinaryResponseScoreRecord.select(:assignment_id).map(&:assignment_id).uniq.sort
    @assignment_ids.each do |assignment_id|
      @assignment = Assignment.find(assignment_id)
      @questionnaire_id = @assignment.questionnaire_id
      @review_num = @assignment.review_num
      @questions = Question.where(questionnaire_id: @questionnaire_id)
      @questions.each do |question|
        word_count = 0
        @ordinary_records = OrdinaryResponseScoreRecord.where(assignment_id: assignment_id, question_id: question.id)
        @ordinary_records.each do |ordinary_record|
          word_count += words_counted(ordinary_record.comments)
        end
        average_word_count = word_count * 1.0 / @review_num
        @iterate += 1
        QuestionQuality.create(id: @iterate, assignment_id: assignment_id, question_id: question.id, average_word_count: average_word_count)
      end
    end
  end

  def all_questions_comments_not_null_percentage
    @iterate = 0
    @questionnaires = Questionnaire.all
    @assignment_ids = OrdinaryResponseScoreRecord.select(:assignment_id).map(&:assignment_id).uniq.sort
    @assignment_ids.each do |assignment_id|
      @assignment = Assignment.find(assignment_id)
      @questionnaire_id = @assignment.questionnaire_id
      @review_num = @assignment.review_num
      @questions = Question.where(questionnaire_id: @questionnaire_id)
      @questions.each do |question|
        @not_null_record_num = 0
        @ordinary_records = OrdinaryResponseScoreRecord.where(assignment_id: assignment_id, question_id: question.id)
        @total_record_num = @ordinary_records.size
        @ordinary_records.each do |ordinary_record|
          if ordinary_record.word_count > 0
            @not_null_record_num += 1
          end 
        end
        @percentage = @not_null_record_num * 1.0 / @total_record_num
        @iterate += 1
        @question_quality = QuestionQuality.find(@iterate)
        @question_quality.update_attribute('percentage', @percentage)
      end
    end
  end
end

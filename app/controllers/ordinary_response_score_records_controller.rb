class OrdinaryResponseScoreRecordsController < ApplicationController
  def index
    @ordinary_response_score_records = OrdinaryResponseScoreRecord.all
    #@ordinary_response_score_records.each do |item|
    #  word_count = words_counted(item.comments)
    #  item.update_attribute('word_count', word_count)
    #end
    #whole_response_words_counted
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
    @questionnaires = Questionnaire.all
    @questionnaires.each do |questionnaire|
      @assignments = Assignment.where(questionnaire_id: questionnaire.id)
      @questions = Question.where(questionnaire_id: questionnaire.id)
      @questions.each do |question|
        @assignments.each do |assignment|
          word_count = 0
          review_num = assignment.review_num
          @ordinary_records = OrdinaryResponseScoreRecord.where(assignment_id: assignment.id, question_id: question.id)
          @ordinary_records.each do |ordinary_record|
            word_count += words_counted(ordinary_record.comments)
          end
          average_word_count = word_count / review_num
          question_quality = QuestionQuality.create(assignment_id: assignment.id, question_id: question.id, word_count: average_word_count) 
        end
      end
    end
  end
end

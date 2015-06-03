class CustomResponseScoreRecordsController < ApplicationController
  def index
    #@custom_response_score_records = CustomResponseScoreRecord.all
    #@custom_response_score_records.each do |item|
    #  word_count = words_counted(item.comments)
    #  item.update_attribute('word_count', word_count)
    #end
    #@questions = Question.all
    #@questions.each do |q|
    #  word_count = words_counted(q.txt)
    #  q.update_attribute('word_count', word_count)
    #end
    #copy_comments_value_to_score_value_in_every_odd_num_record
    #all_questions_average_words_counted
    #all_questions_comments_not_null_percentage
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

  def copy_comments_value_to_score_value_in_every_odd_num_record
    @custom_response_score_records = CustomResponseScoreRecord.all
    @custom_response_score_records.each do |record|
      #if record.question_id % 2 == 0 or !((1923..1938).to_a.include?(record.question_id) or (2449..2482).to_a.include?(record.question_id))
      #  next
      #end
      #record.update_attributes(score: record.comments, comments: CustomResponseScoreRecord.find(record.id + 1).comments)
      if record.question_id % 2 == 0 and ((1923..1938).to_a.include?(record.question_id) or (2449..2482).to_a.include?(record.question_id))
        record.delete
      end
    end
  end

  def all_questions_average_words_counted
    @iterate = 283
    @questionnaires = Questionnaire.all
    @assignment_ids = CustomResponseScoreRecord.select(:assignment_id).map(&:assignment_id).uniq.sort
    @assignment_ids.each do |assignment_id|
      @assignment = Assignment.find(assignment_id)
      @questionnaire_id = @assignment.questionnaire_id
      @review_num = @assignment.review_num
      @questions = Question.where(questionnaire_id: @questionnaire_id)
      @questions.each do |question|
        word_count = 0
        @ordinary_records = CustomResponseScoreRecord.where(assignment_id: assignment_id, question_id: question.id)
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
    @iterate = 283
    @questionnaires = Questionnaire.all
    @assignment_ids = CustomResponseScoreRecord.select(:assignment_id).map(&:assignment_id).uniq.sort
    @assignment_ids.each do |assignment_id|
      @assignment = Assignment.find(assignment_id)
      @questionnaire_id = @assignment.questionnaire_id
      @review_num = @assignment.review_num
      @questions = Question.where(questionnaire_id: @questionnaire_id)
      @questions.each do |question|
        @not_null_record_num = 0
        @ordinary_records = CustomResponseScoreRecord.where(assignment_id: assignment_id, question_id: question.id)
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

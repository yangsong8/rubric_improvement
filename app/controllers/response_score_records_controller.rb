class ResponseScoreRecordsController < ApplicationController
  require 'statsample'
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
end

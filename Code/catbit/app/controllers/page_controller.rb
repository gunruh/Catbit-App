class PageController < ApplicationController
  def home
    @water = current_user.fitbitClient.water_on_date('today')
    @stats = current_user.fitbitClient.activities_on_date('today')["summary"]
   
    @sleep = current_user.fitbitClient.sleep_on_date('today')
  end

  def water
  end

  def steps
    @steps = current_user.fitbitClient.activities_on_date('today')["summary"]["steps"]
  end

  def calories
  end

  def weight
  end

  def sleep
  end

  def miles
  end
end

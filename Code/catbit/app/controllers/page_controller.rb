class PageController < ApplicationController
  def home
    @water = current_user.fitbitClient.water_on_date('today')
    @stats = current_user.fitbitClient.activities_on_date('today')["summary"]
    @body_measurements = current_user.fitbitClient.body_measurements_on_date('today') 
    @sleep = current_user.fitbitClient.sleep_on_date('today')
  end

  def water
    @water = current_user.fitbitClient.water_on_date('today')["summary"]["water"]
  end

  def steps
    @steps = current_user.fitbitClient.activities_on_date('today')["summary"]["steps"]
  end

  def calories
    @calories = current_user.fitbitClient.activities_on_date('today')["summary"]["activityCalories"]
  end

  def weight
    @weight = current_user.fitbitClient.body_measurements_on_date('today')["body"]["weight"]
  end

  def sleep
    @sleep = current_user.fitbitClient.sleep_on_date('today')["summary"]["totalMinutesAsleep"]%60
  end

  def miles
    @miles = current_user.fitbitClient.activities_on_date('today')['summary']["distances"][0]["distance"]
  end
end

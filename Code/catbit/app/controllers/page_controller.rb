class PageController < ApplicationController
  def home
    @water = current_user.fitbitClient.water_on_date('today')
    @stats = current_user.fitbitClient.activities_on_date('today')["summary"]
    @body_measurements = current_user.fitbitClient.body_measurements_on_date('today') 
    @sleep = current_user.fitbitClient.sleep_on_date('today')
  end

  def water
    # Get Water from database
    @water = current_user.fitbitClient.water_on_date('today')["summary"]["water"]
    @goals = 67
    
    # Get goal from database
    #@goal = 
    
    # Get Barchart data
    
    # Get variables for days of week
    _now = Date.today
    _dayOfWeek = _now.wday
    _sun = _now - _dayOfWeek
    _mon = _sun + 1
    _tue = _sun + 2
    _wed = _sun + 3
    _thu = _sun + 4
    _fri = _sun + 5
    _sat = _sun + 6
    
    
    
    # Request info from each day
    #_sunData = current_user.fitbitClient.water_on_date(_sun)["summary"]["water"]
    #_monData = current_user.fitbitClient.water_on_date(_mon)["summary"]["water"]
    #_tueData = current_user.fitbitClient.water_on_date(_tue)["summary"]["water"]
    #_wedData = current_user.fitbitClient.water_on_date(_wed)["summary"]["water"]
    #_thuData = current_user.fitbitClient.water_on_date(_thu)["summary"]["water"]
    #_friData = current_user.fitbitClient.water_on_date(_fri)["summary"]["water"]
    #_satData = current_user.fitbitClient.water_on_date(_sat)["summary"]["water"]
    
    #@dataArray = [_sunData, _monData, _tueData, _wedData, _thuData, _friData, _satData]
    @dataArray = [3, 5, 3, 4, 4, 13, 2]
    
  end

  def steps
    @steps = current_user.fitbitClient.activities_on_date('today')["summary"]["steps"]
    @goals = current_user.fitbitClient.daily_goals["goals"]["steps"]
    @dataArray = [3, 5, 3, 4, 4, 13, 2]
  end

  def calories
    @calories = current_user.fitbitClient.activities_on_date('today')["summary"]["activityCalories"]
    @goals = current_user.fitbitClient.daily_goals["goals"]["caloriesOut"]
    @dataArray = [3, 5, 3, 4, 4, 13, 2]
  end

  def weight
    @weight = current_user.fitbitClient.body_measurements_on_date('today')
    @dataArray = [3, 5, 3, 4, 4, 13, 2]
  end

  def sleep
    @sleep = current_user.fitbitClient.sleep_on_date('today')["summary"]["totalMinutesAsleep"]
    @dataArray = [3, 5, 3, 4, 4, 13, 2]
  end

  def miles
    @miles = current_user.fitbitClient.activities_on_date('today')['summary']["distances"][0]["distance"]
    @goals = current_user.fitbitClient.daily_goals["goals"]["distance"]
    @dataArray = [3, 5, 3, 4, 4, 13, 2]
  end
end

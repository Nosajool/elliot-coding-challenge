require 'csv'
require 'date'

def format_datetime(time)
  time.strftime("%F %T")
end

class Event
  attr_accessor :start_t, :end_t

  def initialize(start_time, end_time)
    @start_t, @end_t = start_time, end_time
  end

  def <=>(other)
    if @start_t < other.start_t
      return -1
    elsif @start_t == other.start_t
      return 0
    else
      return 1
    end
  end

  def duration
    @end_t - @start_t
  end

  def to_s
    "Event start=#{format_datetime(start_t)} end=#{format_datetime(end_t)}"
  end
end

class SchedulingSolver
  def initialize(file_name)
    @events = []
    @file_name = file_name
    @largest_gap = nil
    parse_and_clean_csv
    preprocess_data
    solve
  end

  def largest_gap
    "Biggest Gap start=#{format_datetime(@largest_gap.start_t)} end=#{format_datetime(@largest_gap.end_t)}"
  end

  private

  def today
    @today ||= Date.today
  end

  def parse_and_clean_csv
    parsed_events = CSV.read(@file_name)

    parsed_events.each do |event|
      # Parse out start time and end time
      start_time = DateTime.parse(event[1])
      end_time = DateTime.parse(event[2])
      if end_time < today || start_time > today + 7
        # Event is in the past or past 1 week from now
        next
      end
      @events << Event.new(start_time, end_time)
    end
  end

  def preprocess_data
    # Add events denoting start and end of day
    midnight = DateTime.new(today.year, today.month, today.day, 0, 0, 0)
    start_of_day = DateTime.new(today.year, today.month, today.day, 8, 0, 0)
    end_of_day = DateTime.new(today.year, today.month, today.day, 22, 0, 0)
    midnight_night = DateTime.new(today.year, today.month, today.day, 23, 59, 59)

    7.times do |i|
      @events << Event.new(midnight + i, start_of_day + i)
      @events << Event.new(end_of_day + i, midnight_night + i)
    end
  end

  def solve
    @events.sort! # Sort by ascending start time
    last_event_end = @events[0].end_t
    i = 1
    while i < @events.size
      event = @events[i]
      break if event.start_t > today + 7 # Too far away
      if event.start_t > last_event_end
        # We have a gap, check if it is the largest
        if @largest_gap == nil || (@largest_gap && (event.start_t - last_event_end) > @largest_gap.duration)
          @largest_gap = Event.new(last_event_end, event.start_t)
        end
      end

      if event.end_t > last_event_end
        last_event_end = event.end_t
      end

      i += 1
    end
  end
end

solver = SchedulingSolver.new('calendar.csv')
puts solver.largest_gap

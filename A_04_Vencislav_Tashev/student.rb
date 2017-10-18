class DateTime
  def delay_in_seconds(timestamp)
    ((self - timestamp) * 24 * 60 * 60).to_i.abs
  end
end

class Student
  attr_reader :timestamp, :clazz, :number, :first_name, :last_name, :url_string

  @@date_format = '%d/%m/%Y %H:%M:%S'
  @@deadline = DateTime.strptime '10/10/2017 23:59:59', @@date_format

  def initialize(timestamp, clazz, number, first_name, last_name, url_string)
    @timestamp = DateTime.strptime timestamp, @@date_format
    @clazz = self.parse_clazz clazz
    @number = number.to_i
    @first_name = first_name.strip
    @last_name = last_name.strip
    @url_string = url_string.strip
  end

  def parse_clazz(clazz)
    clazz.gsub!(' ', '')
    clazz.gsub!('10', '11')
    clazz.gsub!('XI', '11')
    clazz.gsub!(/[aAаА]/, 'A')
    clazz.gsub!(/[bBбБ]/, 'B')
    clazz.gsub!(/^A$/, '11A')
    clazz.gsub!(/^B$/, '11B')
    clazz
  end

  def timestamp
    @timestamp.strftime @@date_format
  end

  def full_name
    "#{@first_name} #{@last_name}"
  end

  def on_time?
    @timestamp <= @@deadline
  end

  def delay
    @@deadline.delay_in_seconds @timestamp
  end

  def to_s
    "#{full_name} (#{@clazz}, ##{@number})"
  end
end

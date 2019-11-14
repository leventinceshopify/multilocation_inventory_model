class State
  attr_accessor :status, :information

  def initialize (status, information = "")
      @status = status
      @information = information
  end

  def to_s
    "#{@status} "
  end

end

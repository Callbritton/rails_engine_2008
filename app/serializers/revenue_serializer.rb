class RevenueSerializer
  include FastJsonapi::ObjectSerializer
  set_id 'nil?'

  attribute :revenue do |num|
    num
  end
end

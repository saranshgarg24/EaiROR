class PhoneNumber < ApplicationRecord

  paginates_per 2

  def self.create_random_phone_number
    flag = true
    phone_number = nil
    while flag do
      a = [1,2,3,4,5,6].shuffle.first
      if a.even?
        number = Time.now.to_i.to_s
        first_part = number[0..2].to_i
        second_part = number[3..5].to_i
        third_part = number[6..9].to_i
        if third_part < 1111 || second_part < 111 || first_part < 111 || number.length != 10
          number = generate_random_number
        end
      else
        number = generate_random_number
      end
      unless self.exists?(number: number)
        flag = false
        phone_number = create(number: number)
      end
    end
    phone_number
  end

  def self.generate_number given_number
    if given_number.present?
      if self.exists?(number: given_number)
        create_random_phone_number
      else
        create(number: given_number)
      end
    else
      create_random_phone_number
    end
  end

  private

  def self.generate_random_number
    (111 + rand(889)).to_s + (111 + rand(889)).to_s + (1111 + rand(8889)).to_s
  end

end

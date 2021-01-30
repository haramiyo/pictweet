class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tweets
  has_many :comments

  validates :nickname, presence: true, length: { maximum: 6 }
  # validates :email, presence: true
  # validates :password, presence: true
end

def quick_sort(ary)
  return ary if ary.length < 2
  # binding.pry
  pivot = ary.shift
  smaller = []
  bigger  = []
  ary.each do |num|
    if num < pivot
      smaller << num
    else
      bigger << num
    end
  end
  quick_sort(smaller) + [pivot] + quick_sort(bigger)
end
ary = [89, 45, 32, 367, 122, 67, 14, 245]
p ary
p quick_sort(ary)
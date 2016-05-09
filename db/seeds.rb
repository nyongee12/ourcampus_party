# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

# make schedule
9.upto(31) do |i|
  Schedule.create(date: DateTime.new(2016, 5, i))
end

# # make univ
# file = open('public/Univ.csv')
# Univ.import(file)
#
# # make festival
# file = open('public/Festival.csv')
# Festival.import(file)
#
# # make festival_schedule
# file = open('public/FestivalSchedule.csv')
# FestivalSchedule.import(file)

file = open('public/Festival_2016May.csv')
Festival.import(file)

=begin
# make celeb
Celeb.create(name: '거미')
Celeb.create(name: '아이유')
Celeb.create(name: '에픽하이')
Celeb.create(name: '여자친구')
Celeb.create(name: '마마무')
Celeb.create(name: '10cm')
Celeb.create(name: '싸이')
Celeb.create(name: '버벌진트')
Celeb.create(name: '다이나믹듀오')
Celeb.create(name: '어쿠스틱콜라보')
Celeb.create(name: '블랙넛')
Celeb.create(name: '씨스타')
Celeb.create(name: 'DJ DOC')
Celeb.create(name: '기리보이')
Celeb.create(name: '빈지노')
Celeb.create(name: '도끼')
Celeb.create(name: '산이')
Celeb.create(name: '로꼬')
Celeb.create(name: '러블리')
Celeb.create(name: '시크릿')
Celeb.create(name: '트와이스')


# make celeb_festival_schedule
Celeb.all.each do |c|
  count = (2..5).to_a.sample
  j = 0
  while
    fs = FestivalSchedule.order("RANDOM()").first
    next if c.festival_schedules.where(festival_id: fs.festival_id).count > 0
    j+=1
    c.celeb_festival_schedules.create(festival_schedule_id: fs.id)
    break if j >= count
  end
end
=end


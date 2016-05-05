# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# make schedule
6.upto(31) do |i|
  Schedule.create(date: DateTime.new(2016, 5, i))
end

# make univ
Univ.create(name: '서강대학교')
Univ.create(name: '한양대학교')
Univ.create(name: '단국대학교')
Univ.create(name: '한양대학교 에리카')
Univ.create(name: '연세대학교')
Univ.create(name: '이화여자대학교')
Univ.create(name: '서울대학교')

# make festival
1.upto(6) do |i|
  Festival.create(univ_id: i)
end

# make festival_schedule
1.upto(6) do |i|
  start = (1..23).to_a.sample
  count = (2..4).to_a.sample
  start.upto(start+count) do |id|
    FestivalSchedule.create(festival_id: i, schedule_id: id)
  end
end

# make celeb
Celeb.create(name: '거미')
Celeb.create(name: '아이유')
Celeb.create(name: '에픽하이')
Celeb.create(name: '여자친구')
Celeb.create(name: '마마무')
Celeb.create(name: '10cm')
Celeb.create(name: '싸이')

# make celeb_festival_schedule
1.upto(7) do |i|
  count = (2..5).to_a.sample
  fs = FestivalSchedule.order("RANDOM()").first(count)
  fs.each do |f|
    CelebFestivalSchedule.create(celeb_id: i, festival_schedule_id: f.id)
  end

end


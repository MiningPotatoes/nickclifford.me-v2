.main
    / why is this returning Iterator.stop but #each still works?? what????
    /- f_time_day, f_advisee = day_pairs.next
    /h1= f_advisee
    /h2= f_time_day[0].to_s("%A, %B %-d")

.future-dates
  - day_pairs.each do |(time_day, advisee)|
    h2 #{advisee}: #{time_day[0].to_s("%F")}, Day #{time_day[1]}

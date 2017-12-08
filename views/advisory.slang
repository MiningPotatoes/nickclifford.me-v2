.main
  h1 Nick
  - if days.nil?
    h2 whoops we had a mistake, try again later
  - else
    - day_pairs.not_nil!.each do |(advisee, time_day)|
      h2 #{advisee}: #{time_day[0].to_s("%F")}, Day #{time_day[1]}

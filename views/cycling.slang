.main
  - cyclists.each do |cyclist|
    h2 #{cyclist[:name]}: #{cyclist[:falls]} fall#{'s' unless cyclist[:falls] == 1}

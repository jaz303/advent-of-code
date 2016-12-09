input = File.read("input.raw").split(",").map(&:strip)

File.open("input.s", "w") do |f|
  f.puts(".global count")
  f.puts(".global data")
  f.puts("")
  f.puts("count:")
  f.puts(".word #{input.length}")
  f.puts("")

  f.puts("data:")
  input.each do |line|
    h = line[0..0]
    d = line[1..-1]
    f.puts(".word #{h == 'R' ? '0' : '1'}, #{d}")
  end
  f.puts("")
end
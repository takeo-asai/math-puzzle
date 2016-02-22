N = 4

def search(rows)
  return 1 if rows.size == N
  count = 0
  (2**N).times do |row|
    cross = rows.select {|r| (row & ~r) > 0 && (~row & r) > 0}
    count += search(rows+[row]) if cross.count == 0
  end
  return count
end
p search([])

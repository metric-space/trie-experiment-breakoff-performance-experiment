require 'rambling-trie'
require 'bk'
require 'benchmark'
require 'terminal-table'

dictionary_file = "dictionary.txt" 

file = File.open(dictionary_file,'r')

array_of_words = []
while (line = file.gets) 
  array_of_words << line.split("\n")[0]
end


trieNaive = Rambling::Trie.create 
trieSplit = {}
trieConcurrent = {}

bkNaive = BK::Tree.new
bkSplit = {}
bkConcurrent = {}


######## the native approach ########

timeTrieNaive = Benchmark.realtime do 
  array_of_words.map do |x| 
    trieNaive << x
  end
end

timeBkNaive = Benchmark.realtime do 
  array_of_words.map do |x| 
    bkNaive.add x
  end
end

########## the split approach ######################

timeTrieSplit = Benchmark.realtime do
 # wordsMap :: Map Char [String]
 wordsMap = array_of_words.group_by {|x| x[0]}
 wordsMap.keys.map do |i|
  trieSplit[i] = Rambling::Trie.create 
  wordsMap[i].map {|x| trieSplit[i] <<  x}
 end
end

timeBkSplit = Benchmark.realtime do
 # wordsMap :: Map Char [String]
 wordsMap = array_of_words.group_by {|x| x[0]}
 wordsMap.keys.map do |i|
  bkSplit[i] = BK::Tree.new
  wordsMap[i].map {|x| bkSplit[i].add  x}
 end
end



rowsNaive = []
rowsNaive << ['Trie' ,timeTrieNaive]
rowsNaive << ['BK' , timeBkNaive]
tableNaive = Terminal::Table.new title: "Naive Approach", headings: ['structure','time'], rows: rowsNaive


rowsSplit = []
rowsSplit << ['Trie' ,timeTrieSplit]
rowsSplit << ['BK' , timeBkSplit]
tableSplit = Terminal::Table.new title: "Split Approach", headings: ['structure','time'], rows: rowsSplit

puts tableNaive
puts "\n\n"
puts tableSplit
puts "\n\n"

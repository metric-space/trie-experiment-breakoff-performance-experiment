require 'rambling-trie'
require 'bk'
require 'benchmark'
require 'terminal-table'
require 'parallel'

dictionary_file = "dictionary.txt" 

file = File.open(dictionary_file,'r')

array_of_words = []
while (line = file.gets) 
  array_of_words << line.split("\n")[0]
end


trieNaive = Rambling::Trie.create 
trieSplit = {}
trieParallel = {}

bkNaive = BK::Tree.new
bkSplit = {}
bkParallel = {}


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

########## the parallel approach ######################

timeTrieParallel = Benchmark.realtime do
  # wordsMap :: Map Char [String]
  wordsMap = array_of_words.group_by {|x| x[0]}
  Parallel.map(wordsMap.keys) do |i|
    trieParallel[i] = Rambling::Trie.create 
    wordsMap[i].map {|x| trieParallel[i] <<  x}
  end 
end

timeBkParallel = Benchmark.realtime do
  # wordsMap :: Map Char [String]
  wordsMap = array_of_words.group_by {|x| x[0]}
  Parallel.map(wordsMap.keys) do |i|
    bkParallel[i] = BK::Tree.new 
    wordsMap[i].map {|x| bkParallel[i].add  x}
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

rowsParallel = []
rowsParallel << ['Trie' ,timeTrieParallel]
rowsParallel << ['BK' , timeBkParallel]
tableParallel = Terminal::Table.new title: "Parallel Approach", headings: ['structure','time'], rows: rowsParallel


puts tableNaive
puts "\n\n"
puts tableSplit
puts "\n\n"
puts tableParallel
puts "\n\n"

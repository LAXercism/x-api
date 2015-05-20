require './lib/xapi'

#class Todo

  def get_slugs
    slugs = []
    Dir.glob("./metadata/*.yml").each do |filename|
      slugs << filename[11...-4]
    end
    slugs
  end

  def get_tracks
    tracks = []
    tracksfiles = Dir.glob("./problems/*")
    tracksfiles.each do |filename|
      tracks << filename[11..-1]
    end
    tracks
  end

  def get_slugsdone
    slugsdone = {}
    get_tracks.each do |track|
        slugsdone[track] = Xapi::Config.find(track).slugs
    end
    slugsdone
  end

  def get_todo
    todo = {}
    get_tracks.each do |track|
      todo[track] = get_slugs - get_slugsdone[track]
    end
    todo
  end

  def track1not2(track1, track2)
      #what is done in track1 but not done in track2
    track1not2 = get_slugsdone[track1] - get_slugsdone[track2]
  end

#end

#snake = Todo.new

#puts snake.get_slugs

puts get_slugsdone["go"].size
puts get_slugsdone["python"].size
puts track1not2("go", "python").size
puts track1not2("python", "go").size

puts (track1not2("python", "go") == track1not2("go", "python"))







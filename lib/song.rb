require 'pry'

class Song
    attr_accessor :name, :artist, :genre
    
    @@all = []

    def initialize(name, artist= nil, genre= nil)
        @name = name
        # self.artist= artist
        # self.genre= genre
        #save
        self.artist=(artist) unless artist == nil
        self.genre=(genre) unless genre == nil
    end

    def save
        @@all << self
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(name)
        new_song = Song.new(name)
        new_song.save
        new_song
    end

    def artist=(artist)
        if @artist == nil
            @artist = artist
        else
            @artist = @artist
        end
        if self.artist != nil
            @artist.add_song(self)
        end
    end

    def self.find_by_name(song_name)
        #binding.pry
        @@all.detect { |song| song.name == song_name }
    end

    def self.find_or_create_by_name(song_name)
        find_by_name(song_name) || self.create(song_name)
    end

end

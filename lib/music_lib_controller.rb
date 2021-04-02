class MusicLibraryController

    extend Concerns::Findable

    def initialize(path= "./db/mp3s")
        @path = path
        MusicImporter.new(path).import
    end

    def call
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"

        input = gets.strip
        call unless input == "exit"

        case input
        when "list songs"
            list_songs
        when "list artists"
            list_artists
        when "list genres"
            list_genres
        when "list artist"
            list_songs_by_artist
        when "list genre"
            list_songs_by_genre
        when "play song"
            play_song
        end   
    end

    def list_songs
          songs_sorted = Song.all.sort{ |a, b| a.name <=> b.name } 
          songs_sorted.each.with_index(1) do |song, index|
            puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
          end        
    end

    def list_artists
        artists_sorted = Artist.all.sort{ |a, b| a.name <=> b.name } 
          artists_sorted.each.with_index(1) do |artist, index|
            puts "#{index}. #{artist.name}"
          end  
    end

    def list_genres
        genres_sorted = Genre.all.sort_by { |genre| genre.name }
        #binding.pry
          genres_sorted.each.with_index(1) do |genre, index|
            puts "#{index}. #{genre.name}"
          end  
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.strip
        if artist = Artist.find_by_name(input)
            songs_sorted = artist.songs.sort_by do |song|
                song.name
            end
            songs_sorted.each.with_index(1) do |song,index|
                puts "#{index}. #{song.name} - #{song.genre.name}"
            end
        end
    end
    
    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.strip
        if genre = Genre.find_by_name(input)
            songs_sorted = genre.songs.sort_by do |song|
                song.name
            end
            songs_sorted.each.with_index(1) do |song,index|
                puts "#{index}. #{song.artist.name} - #{song.name}"
            end
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        song_list =  Song.all.sort{ |a, b| a.name <=> b.name }
    
        input = gets.strip.to_i
        
        if (1..Song.all.length).include?(input)
            #binding.pry
          song = song_list[input-1]
          puts "Playing #{song.name} by #{song.artist.name}"
        end
    end


end


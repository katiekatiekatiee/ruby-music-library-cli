class MusicImporter

    attr_accessor :path

    def initialize(path)
        @path = path
    end

# def path
#     @path
# end

    def files
        #binding.pry
        @files = Dir.entries(@path)
        @files.delete_if { |file| file == "." || file == ".." }

    end

    def import
        files.each do |filename|
            Song.create_from_filename(filename)
        end
    end


end






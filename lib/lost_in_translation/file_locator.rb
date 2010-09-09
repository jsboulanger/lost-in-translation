module LostInTranslation
  class FileLocator
    def initialize(paths, exts = ['rb'])
      @paths, @exts = [paths, exts]
    end

    def all_files
      valid_paths
    end
    
    def map
      valid_paths.map { |path| yield(path) }
    end

  private

    def all_files(paths)
      paths.map do |path|
        if test 'd', path
          all_files(Dir["#{path}/**/*.{#{@exts.join(',')}}"])
        else
          path
        end
      end.flatten.sort
    end

    def valid_paths
      all_files(@paths).select do |path|
        if test 'f', path
          true
        else
          $stderr.puts "Error: No such file - #{path}"
          false
        end
      end
    end
  end
end

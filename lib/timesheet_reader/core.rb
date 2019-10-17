module TimesheetReader
    class Core
        attr_reader :file_paths, :parser

        def initialize (file_paths)
            @file_paths = file_paths
        end

        def run
            puts @file_paths
        end
    end
end

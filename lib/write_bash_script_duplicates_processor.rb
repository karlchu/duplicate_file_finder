class WriteBashScriptDuplicatesProcessor

  # Writes a bash script to process the duplicates.
  # The script is written out to $stdout.
  # Other messages are written out to $stderr.
  # @param [Hash] duplicates_hash Hash of arrays
  def process_duplicates(duplicates_hash)
    duplicates_hash.each do |file_to_keep, files_to_process|
      write_original_file_comment(file_to_keep)
      files_to_process.each do |file|
        process_duplicate(file)
      end
      write_script_line "\n"
    end
  end

  def write_original_file_comment(file_to_keep)
    write_script_line %Q{# Duplicates of #{escape_quotes(file_to_keep)}}
  end

  private
  def write_script_line(line)
    write_script_header_if_not_written
    $stdout.puts(line)
  end

  def write_script_header_if_not_written
    return if @script_header_written
    $stdout.puts '#!/bin/bash'
    $stdout.puts ''
    @script_header_written = true
  end

  def escape_quotes(file)
    file.gsub('""', %[\"])
  end
end

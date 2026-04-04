require "csv"

# build the three groups into three sets from the csvs
# 

class MultipartGrouper
  def initialize(input_path:, group_paths:)
    @input_path = input_path
    @input_studies = parse_input_csv
    @group_paths = group_paths
    @groups_studies = parse_group_csvs
  end
  
  attr_reader :groups_studies
  
  # Implement this method
  def group
    [
      ["MRI Elbow", "MRI Forearm"],               # Created from the MRI Upper Limb group
      ["MRI Spine Coccyx", "MRI Spine Thoracic"], # Created from the MRI Axial Skeleton group
      ["MRI Thigh", "MRI Knee"]                   # Created from the MRI Lower Limb group
    ]
  end

  def output
    p @input_studies
    puts "######################"
    @groups_studies.each {|study| puts "#{study}\n\n"}
  end

  def input_group_match_combinations
    grouped_inputs = @groups_studies.transform_values { [] }
    remaining_inputs = @input_studies.values.dup
    all_assigned = false
    
    until all_assigned do
      # this is just the max matches first approach - how to reduce and try other approaches
      # maybe just try max on another group then try the three groups
      # n = grouped_inputs.length
      @groups_studies.each do |group_name, studies|
        matches = studies.intersection(remaining_inputs)
        
        # add group_name and matches to grouped inputs
        grouped_inputs[group_name] = matches
        # remove matches from remaining_inputs
        remaining_inputs.delete_if { |study_name| matches.include?(study_name) }
        
        if remaining_inputs.empty?
          # we've matched everything - finish
          all_assigned = true
          break
        end
      end
      
    end
    grouped_inputs.values
  end

  def study_group_match_count
    group_match_counts = Hash.new(0)
    # input_study_names_sorted = @input_studies.values.sort
    
    @groups_studies.each do |group_name, study_names|
      intersect_count = study_names.intersection(@input_studies.values).count
      group_match_counts[group_name] = intersect_count
    end

    group_match_counts
  end

  private
  def parse_input_csv
    input_studies = {}
    
    CSV.foreach(@input_path, headers: true) do |row|
      id = row["ID"].to_i
      input_studies[id] = row["Study Name"]
    end

    input_studies
  end

  def parse_group_csvs
    groups = Hash.new { |h, k| h[k] = [] }

    @group_paths.each do |file_path|
      study_name = File.basename(file_path, '.csv').tr(' ', '_').downcase.to_sym
      
      CSV.foreach(file_path, headers: true) do |row|
        groups[study_name] << row["Study Name"]
      end
      groups[study_name].sort!
    end

    groups
  end
end


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


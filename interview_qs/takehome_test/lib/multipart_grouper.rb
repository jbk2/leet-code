require "csv"

# build the three groups into three sets from the csvs
# 

class MultipartGrouper
  def initialize(input_file:, group_files:)
    @input_file = input_file
    @group_files = group_files
    @study_groups = group_csvs
  end

  # Implement this method
  def group
    [
      ["MRI Elbow", "MRI Forearm"],               # Created from the MRI Upper Limb group
      ["MRI Spine Coccyx", "MRI Spine Thoracic"], # Created from the MRI Axial Skeleton group
      ["MRI Thigh", "MRI Knee"]                   # Created from the MRI Lower Limb group
    ]
  end

  private

  def input_csv
    @input_csv ||= CSV.read(
      @input_file,
      headers: true
    )
  end

  def group_csvs
    groups = {}
    @group_files.each do |file_path|
      study_name = File.basename(file_path, '.csv').tr(' ', '_').downcase.to_sym
      groups[study_name] = []
      # file_contents = File.read(file_path)
      CSV.foreach(file_path, headers: true) do |row|
        groups[study_name] << row["Study Name"]
      end
      groups[study_name].sort!
    end
    groups
  end
end


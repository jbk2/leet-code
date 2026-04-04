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

  # Approach - Iterate, at most, the following ammount of times;
  #   (0..no_of_groups -1) x (0..no_of_input_studies - 1) times
  # using iterating counters to remove/dock (via pop) matches from;
  #   greedy matches of - group study names & remaining (unassigned) input study names
  # and assign the undocked matches to the group name, then
  # match remaining input study names against remaining group study names
  # when zero remaining input study names, returned matched/group assigned input studys
  # To note:
  # - greedy strategy used in assignment of input studies to study groups
  # - docking/removal implemented by popping from matches, i.e. docking order does not vary
  #   varying docking order would provide more thorough combination checking
  
  def input_group_match_combinations
    
    no_of_groups = @groups_studies.length; no_of_input_studies = @input_studies.length
    
    (0..no_of_groups - 1).each do |docked_group_no|
      docked_group_name = @groups_studies.keys[docked_group_no]
      
      (0..no_of_input_studies - 1).each do |docked_match_count|
        remaining_inputs = @input_studies.values.dup
        grouped_inputs = @groups_studies.transform_values { [] }

        @groups_studies.each do |group_name, groups_studies|
          matches = groups_studies.intersection(remaining_inputs)
          match_removal_count = [matches.count, docked_match_count].min
          matches.pop(match_removal_count) if group_name == docked_group_name
          grouped_inputs[group_name] = matches
          remaining_inputs.delete_if { |study_name| matches.include?(study_name) }
        end

        if remaining_inputs.empty?
          return grouped_inputs.values 
        end
      end
    end

    return "unmatchables remain"

  end
    
  #   until all_assigned do
  #     grouped_inputs = @groups_studies.transform_values { [] }
  #     remaining_inputs = @input_studies.values.dup
      
  #     docked_matches_group = @groups_studies.keys.sample
      
  #     @groups_studies.each do |group, studies|
  #       matches = studies.intersection(remaining_inputs)    
        
  #       # remove matches from first group in order to trial different match combinations
  #       match_removal_count += 1 while match_removal_count < matches.count
        
  #       if group == docked_matches_group
  #         to_delete = matches.sample(match_removal_count)
  #         matches = matches.delete_if { |match| to_delete.include?(match) }
  #       end
        
  #       # add group_name matches
  #       grouped_inputs[group] = matches
  #       # update remaining with those already matched
  #       remaining_inputs.delete_if { |study_name| matches.include?(study_name) }
        
  #       if remaining_inputs.empty?
  #         # we've matched everything - finish
  #         all_assigned = true
  #         break
  #       end
  #     end
      
  #   end
  #   grouped_inputs.values
  # end

  # Approach - Max match assignment, then assigning remainer
  # 

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


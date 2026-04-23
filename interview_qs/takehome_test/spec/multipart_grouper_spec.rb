require "spec_helper"
require_relative "../lib/multipart_grouper"

RSpec.describe MultipartGrouper do
  let(:group_paths) { Dir.glob("./spec/fixtures/groups/MRI*.csv") }
  let(:input_path) { "./spec/fixtures/inputs/#{input_pathname}.csv" }

  subject do
    MultipartGrouper.new(input_path: input_path, group_paths: group_paths)
  end

  context "parsing the input csv" do
    let(:input_pathname) { "test_one" }
    it ":parse_input_csv returns hash of study ids and names" do
      parsed_input_study_names = { 1 => "MRI Cervical Spine", 2 => "MRI Elbow", 3 => "MRI Lumbar Spine",
        4 => "MRI Pelvis", 5 => "MRI Spine Sacrum", 6 => "MRI Spine Coccyx" }

      expect(subject.send(:parse_input_csv)).to eq(parsed_input_study_names)
    end
  end 
  
  context "parsing the groups" do
    let(:input_pathname) { "test_one" }
    it ":parse_group_csvs returns a hash table of study group name to study names" do
      group_table = { "mri_axial_skeleton" => ["MRI Cervical Spine","MRI Hip Both","MRI Lumbar Spine","MRI Pelvis","MRI SIJ Both","MRI Spine Coccyx","MRI Spine Lumbar/Sacral","MRI Spine Sacrum","MRI Spine Thoracic"],
      "mri_lower_limb" => ["MRI Ankle","MRI Femur","MRI Foot","MRI Hip","MRI Knee","MRI Lower Leg","MRI Lumbar Spine","MRI Pelvis","MRI SIJ","MRI SIJ Both","MRI Spine Coccyx","MRI Spine Sacrum","MRI Thigh"],
      "mri_upper_limb" => ["MRI Brachial Plexus","MRI Cervical Spine","MRI Elbow","MRI Fingers","MRI Forearm","MRI Hand","MRI Radius & Ulnar","MRI Scaphoid","MRI Scapula","MRI Shoulder","MRI Thumb","MRI Upper Arm","MRI Wrist"]
      }

      expect(subject.send(:parse_group_csvs)).to eq(group_table)
    end
  end
  
  context "counting number of matches in each study" do
    let(:input_pathname) { "test_one" }
    it "returns an array of count integers for each study group" do
      count_result = { "mri_axial_skeleton" => 5, "mri_lower_limb" => 4, "mri_upper_limb" => 2 }
      expect(subject.study_group_match_count.length).to be(3)
      expect(subject.study_group_match_count).to eq(count_result)
    end
  end

  context "recording which group(s) each MRI study could allocated to" do
    describe ":study_group_table" do
      let(:input_pathname) { "test_one" }
      it "returns a hash with each studies possible groups" do
        result = {
          "MRI Cervical Spine" => { groups: ['mri_axial_skeleton', 'mri_upper_limb'], id: 1 },
          "MRI Elbow" => { groups: ['mri_upper_limb'], id: 2 },
          "MRI Lumbar Spine" => {groups: ['mri_axial_skeleton', 'mri_lower_limb'], id: 3 },
          "MRI Pelvis" => { groups: ['mri_axial_skeleton', 'mri_lower_limb'], id: 4 },
          "MRI Spine Sacrum" => {groups: ['mri_axial_skeleton', 'mri_lower_limb'], id: 5 },
          "MRI Spine Coccyx" => { groups: ['mri_axial_skeleton', 'mri_lower_limb'], id: 6 }
        }
        expect(subject.study_groups).to eq(result)
      end
    end
  end
  
  describe ":group tests" do
    context "test_one.csv" do
      let(:input_pathname) { "test_one" }
      
      it "finds correct groups of two, two and two" do
        expect(subject.group).to eq(
          [
            ["MRI Elbow", "MRI Cervical Spine"],
            ["MRI Lumbar Spine", "MRI Pelvis"],
            ["MRI Spine Sacrum", "MRI Spine Coccyx"]
          ]
          )
      end
    end
      
    context "test_two.csv" do
      let(:input_pathname) { "test_two" }
      it "finds the expect group of 5, the one remainder is not included as it is not a group" do
        expect(subject.group).to eq([["MRI Thigh", "MRI Knee", "MRI Femur", "MRI Lower Leg", "MRI Ankle"]])
      end
    end
        
    context "test_three.csv" do
      let(:input_pathname) { "test_three" }
      
      it "groups unique study names; duplicate input rows are ignored" do
        expect(subject.group).to eq(
          [
            ["MRI Elbow", "MRI Cervical Spine"],
            ["MRI Spine Lumbar/Sacral", "MRI Spine Coccyx"],
            ["MRI SIJ Both", "MRI Pelvis"]
          ]
        )
      end
    end
    
    context "solved_example.csv" do
      let(:input_pathname) { "solved_example" }
      
      it "groups unique study names; duplicate input rows are ignored" do
        expect(subject.group).to eq(
          [
            ["MRI Thigh", "MRI Knee"],                  # Created from the MRI Lower Limb group
            ["MRI Elbow", "MRI Forearm"],               # Created from the MRI Upper Limb group
            ["MRI Spine Thoracic", "MRI Spine Coccyx"]  # Created from the MRI Axial Skeleton group
          ]
        )
      end
    end
    
  end
end 
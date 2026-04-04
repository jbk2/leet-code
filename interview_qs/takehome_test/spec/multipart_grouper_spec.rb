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
    it ":parse_input_csv returns hash if study ids and names" do
      parsed_input_study_names = { 1 => "MRI Cervical Spine", 2 => "MRI Elbow", 3 => "MRI Lumbar Spine",
        4 => "MRI Pelvis", 5 => "MRI Spine Sacrum", 6 => "MRI Spine Coccyx" }

      expect(subject.send(:parse_input_csv)).to eq(parsed_input_study_names)
    end
  end 
  
  context "parsing the groups" do
    let(:input_pathname) { "test_one" }
    it ":parse_group_csvs returns a hash table of study group name to study names" do
      group_table = { mri_axial_skeleton: ["MRI Cervical Spine","MRI Hip Both","MRI Lumbar Spine","MRI Pelvis","MRI SIJ Both","MRI Spine Coccyx","MRI Spine Lumbar/Sacral","MRI Spine Sacrum","MRI Spine Thoracic"],
      mri_lower_limb: ["MRI Ankle","MRI Femur","MRI Foot","MRI Hip","MRI Knee","MRI Lower Leg","MRI Lumbar Spine","MRI Pelvis","MRI SIJ","MRI SIJ Both","MRI Spine Coccyx","MRI Spine Sacrum","MRI Thigh"],
      mri_upper_limb: ["MRI Brachial Plexus","MRI Cervical Spine","MRI Elbow","MRI Fingers","MRI Forearm","MRI Hand","MRI Radius & Ulnar","MRI Scaphoid","MRI Scapula","MRI Shoulder","MRI Thumb","MRI Upper Arm","MRI Wrist"]
    }
    
    expect(subject.send(:parse_group_csvs)).to eq(group_table)
  end
end

context "counting number of matches in each study" do
  let(:input_pathname) { "test_one" }
  it "returns and array of count integers for each study group" do
    count_result = { mri_axial_skeleton: 5, mri_lower_limb: 4, mri_upper_limb: 2 }
    expect(subject.study_group_match_count.length).to be(3)
    expect(subject.study_group_match_count).to eq(count_result)
    p subject.input_group_match_combinations
  end
end
  
  context "finds correct groups of two two and two" do
    let(:input_pathname) { "solved_example" }

    xit "creates the expected mapping of 3 groups of 2 studies" do
      expect(subject).to eq(
        [
          ["MRI Elbow", "MRI Forearm"],               # Created from the MRI Upper Limb group
          ["MRI Spine Coccyx", "MRI Spine Thoracic"], # Created from the MRI Axial Skeleton group
          ["MRI Thigh", "MRI Knee"]                   # Created from the MRI Lower Limb group
        ]
      )
    end
  end

  context "Test input group one" do
    let(:input_pathname) { "test_one" }

    xit "finds correct groups of two and four studies with no remainders" do
      expect(subject).to eq(
        [
          [
            "MRI Cervical Spine",
            "MRI Elbow"
          ],
          [
            "MRI Lumbar Spine",
            "MRI Pelvis",
            "MRI Spine Sacrum",
            "MRI Spine Coccyx"
          ]
        ]
      )
    end
  end

  context "Test input group two" do
    let(:input_pathname) { "test_two" }

    xit "finds the expect group of 5, the one remainder is not included as it is not a group" do
      expect(subject).to eq(
        [
          [
            "MRI Thigh",
            "MRI Knee",
            "MRI Femur",
            "MRI Lower Leg",
            "MRI Ankle"
          ]
        ]
      )
    end
  end

  context "Test input group three" do
    let(:input_pathname) { "test_three" }

    xit "creates the expected groups of six and two studies with no remainders" do
      expect(subject).to eq(
        [
          [
            "MRI Cervical Spine",
            "MRI Spine Coccyx",
            "MRI Spine Lumbar/Sacral",
            "MRI SIJ Both",
            "MRI Pelvis",
            "MRI Cervical Spine"
          ],
          [
            "MRI Elbow",
            "MRI Elbow"
          ]
        ]
      )
    end
  end
end

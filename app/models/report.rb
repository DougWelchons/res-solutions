class Report < ApplicationRecord
after_create :build_report_sections

  has_many :sections
  has_many :sub_sections, through: :sections
  has_many :parts, through: :sub_sections
  has_many :related_pt1s, through: :parts
  has_many :related_pt2s, through: :parts
  has_many :related_pt3s, through: :parts
  has_many :additional_documents, through: :parts
  has_many :interviews, through: :sections
  has_many :interview_questions, through: :parts


  validates :name, presence: true, uniqueness:true
  validates :company, presence: true

  enum status: [:prep, :kick_off, :document_review, :field_review, :reporting, :closed]

  def build_report_sections

    #  has no associated pt1
      # PT2
        # 100.2.2.13
        # 100.2.2.14
        # 100.2.2.15
        # 102.2.7.7
        # 102.2.8.1
        # 100.5.14.11 (with 100.5.14.15)
      # PT3
        # 100.1.6.7
        # 100.2.8.18
        # 100.2.8.19
        # 101.5.7.1
        # 100.5.9.13
        # 100.5.13.12
        # 100.5.14.15 (with 100.5.14.11)

    # Special notes
    # 101.2.3.1 & 101.2.3.2 are associated with 100.2.3.3

    structure = [
      {section_name: "P1 Ethics", sub_sections: [
          {number: "1.1", name: "LEGAL COMPLIANCE", parts: {
            p100: {pt1: 5, pt2: [1], pt3: [1, 5]},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }},
          {number: "1.2", name: "FINANCIAL DISCLOSURE", parts: {
            p100: {pt1: 2, pt2: [1, 2], pt3: [1, 2]},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }},
          {number: "1.3", name: "BRIBERY, CORRUPTION, MONEY LAUNDERING & FINANCING OF TERRORISM", parts: {
            p100: {pt1: 3, pt2: [1], pt3: []},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }},
          {number: "1.4", name: "MANAGEMENT SYSTEMS", parts: {
            p100: {pt1: 11, pt2: [1, 3, 4, 5, 6, 7, 8], pt3: [1, 3, 4, 5, 7, 8, 10]},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 1, pt2: [], pt3: []}
          }},
          {number: "1.5", name: "CONTRACTORS", parts: {
            p100: {pt1: 1, pt2: [1], pt3: [1]},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }},
          {number: "1.6", name: "TRANSPARENCY & DISCLOSURE", parts: {
            p100: {pt1: 2, pt2: [1, 2], pt3: [1, 2, nil]}, #####!!!!!!!!!!!!!!##### "3"
            p101: {pt1: 1, pt2: [1], pt3: [1]},
            p102: {pt1: 2, pt2: [], pt3: []}
          }}]},
      {section_name: "P2 Social", sub_sections: [
          {number: "2.1", name: "HUMAN RIGHTS", parts: {
            p100: {pt1: 4, pt2: [1, 2], pt3: [1, 2, 3]},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }},
          {number: "2.2", name: "FAIR, INCLUSIVE ENGAGEMENT & GOOD FAITH CONSULTATION", parts: {
            p100: {pt1: 6, pt2: [1, 2, 3, 4, 5, 6, nil, nil, nil], pt3: [1, 2, 3, 4]}, #####!!!!!!!!!!!!!!!!!##### "7", "8", "9"
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 1, pt2: [], pt3: []}
          }},
          {number: "2.3", name: "HUMAN RIGHTS & SECURITY PERSONNEL", parts: {
            p100: {pt1: 13, pt2: [1, 2, 11, 13], pt3: [1, 2, 4]},
            p101: {pt1: 0, pt2: [], pt3: []}, # these are part of p100 section 3 (a pt2 and pt3 handled under a special build)
            p102: {pt1: 0, pt2: [], pt3: []}
          }},
          {number: "2.4", name: "LAND RIGHTS", parts: {
            p100: {pt1: 4, pt2: [3], pt3: [2, 3, 4]},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }},
          {number: "2.5", name: "RESETTLEMENT", parts: {
            p100: {pt1: 11, pt2: [7], pt3: []},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }},
          {number: "2.6", name: "UNCONTROLLED SETTLEMENTS", parts: {
            p100: {pt1: 2, pt2: [1], pt3: [1]},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }},
          {number: "2.7", name: "COMMUNITY HEALTH & SAFETY", parts: {
            p100: {pt1: 6, pt2: [2, 3], pt3: []},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 3, pt2: [1, 2, 3, nil], pt3: [1]} #####!!!!!!!!!!!!!!!#####   "4"
          }},
          {number: "2.8", name: "SUSTAINABLE COMMUNITY INVESTMENT", parts: {
            p100: {pt1: 6, pt2: [1, 2, 3, 4, 5, 6], pt3: [1, 2, 4, 5, 6, nil, nil]},  #####!!!!!!!!!!!!!!!!!#####  "7", "8"
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [nil], pt3: []}    #####!!!!!!!!!!!!!!!!!#####  "1"
          }},
          {number: "2.9", name: "CULTURAL HERITAGE", parts: {
            p100: {pt1: 3, pt2: [], pt3: []},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }},
          {number: "2.10", name: "GRIEVANCE MECHANISM", parts: {
            p100: {pt1: 8, pt2: [7], pt3: []},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 1, pt2: [], pt3: []}
          }}]},
      {section_name: "P3 Indigenous", sub_sections: [
          {number: "3.1", name: "FREE, PRIOR & INFORMED CONSENT (FPIC)", parts: {
            p100: {pt1: 2, pt2: [1, 2], pt3: [1, 2]},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 3, pt2: [], pt3: []}
          }},
          {number: "3.2", name: "ENGAGEMENT & PARTICIPATION", parts: {
            p100: {pt1: 8, pt2: [1, 2, 4, 8], pt3: [4]},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }},
          {number: "3.3", name: "CULTURAL IMPACTS", parts: {
            p100: {pt1: 3, pt2: [2], pt3: []},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }},
          {number: "3.4", name: "USE OF TRADITIONAL NATURAL RESOURCES", parts: {
            p100: {pt1: 2, pt2: [2], pt3: []},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }},
          {number: "3.5", name: "CULTURE-BASED INTELLIGENCE & TRADITIONAL KNOWLEDGE", parts: {
            p100: {pt1: 7, pt2: [], pt3: []},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }},
          {number: "3.6", name: "VOLUNTARY ISOLATION", parts: {
            p100: {pt1: 3, pt2: [1], pt3: []},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }}]},
      {section_name: "P4 Labor", sub_sections: [
          {number: "4.1", name: "LABOR & WORKING CONDITIONS", parts: {
            p100: {pt1: 3, pt2: [2], pt3: [2]},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }},
          {number: "4.2", name: "CHILD LABOR", parts: {
            p100: {pt1: 4, pt2: [], pt3: [1, 2]},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }},
          {number: "4.3", name: "FORCED LABOR", parts: {
            p100: {pt1: 3, pt2: [], pt3: [1]},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }},
          {number: "4.4", name: "FREEDOM OF ASSOCIATION & COLLECTIVE BARGAINING", parts: {
            p100: {pt1: 4, pt2: [], pt3: []},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }},
          {number: "4.5", name: "EQUAL OPPORTUNITIES & TREATMENT", parts: {
            p100: {pt1: 8, pt2: [], pt3: []},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }},
          {number: "4.6", name: "WORKING HOURS & LEAVE", parts: {
            p100: {pt1: 2, pt2: [2], pt3: [2]},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }},
          {number: "4.7", name: "REMUNERATION", parts: {
            p100: {pt1: 10, pt2: [1], pt3: []},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }},
          {number: "4.8", name: "WORKPLACE GRIEVANCES", parts: {
            p100: {pt1: 4, pt2: [1], pt3: []},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }},
          {number: "4.9", name: "OCCUPATIONAL HEALTH & SAFETY", parts: {
            p100: {pt1: 14, pt2: [1, 2, 3, 11, 13], pt3: [1, 2, 3]},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 4, pt2: [1, 4], pt3: []}
          }},
          {number: "4.10", name: "EMERGENCY PREPAREDNESS & RESPONSE PLANNING", parts: {
            p100: {pt1: 9, pt2: [], pt3: []},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 1, pt2: [], pt3: []}
          }}]},
      {section_name: "P5 Enviroment", sub_sections: [
          {number: "5.1", name: "ENVIRONMENTAL MANAGEMENT & MITIGATION", parts: {
            p100: {pt1: 3, pt2: [1, 3], pt3: [1, 3]},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }},
          {number: "5.2", name: "EMERGENCY PREPAREDNESS & RESPONSE PLANNING", parts: {
            p100: {pt1: 4, pt2: [1, 4], pt3: [4]},
            p101: {pt1: 2, pt2: [1, 2], pt3: [1]},
            p102: {pt1: 1, pt2: [], pt3: []}
          }},
          {number: "5.3", name: "ENERGY EFFICIENCY", parts: {
            p100: {pt1: 1, pt2: [1], pt3: [1]},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }},
          {number: "5.4", name: "WASTE PRODUCTION & MANAGEMENT", parts: {
            p100: {pt1: 4, pt2: [1, 3, 4], pt3: [3]},
            p101: {pt1: 1, pt2: [], pt3: []},
            p102: {pt1: 2, pt2: [], pt3: []}
          }},
          {number: "5.5", name: "REMEDIATION OF ENVIRONMENTAL LIABILITIES", parts: {
            p100: {pt1: 3, pt2: [1], pt3: [1]},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }},
          {number: "5.6", name: "CLOSURE & RESTORATION", parts: {
            p100: {pt1: 4, pt2: [3], pt3: []},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }},
          {number: "5.7", name: "GREENHOUSE GAS EMISSIONS", parts: {
            p100: {pt1: 5, pt2: [1, 2, 5], pt3: [1, 3, 5]},
            p101: {pt1: 0, pt2: [], pt3: [nil]}, #####!!!!!!!!!!!!!!!!!#####    "1"
            p102: {pt1: 3, pt2: [1, 2], pt3: [2]}
          }},
          {number: "5.8", name: "OZONE DEPLETION", parts: {
            p100: {pt1: 2, pt2: [1], pt3: [1]},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }},
          {number: "5.9", name: "BIODIVERSITY & ECOLOGY", parts: {
            p100: {pt1: 4, pt2: [1, 2, 3, 4], pt3: [1, 2, 3, 4, nil]}, #####!!!!!!!!!!!!!!!!!!#####     "5"
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }},
          {number: "5.10", name: "AIR", parts: {
            p100: {pt1: 2, pt2: [1], pt3: []},
            p101: {pt1: 4, pt2: [1], pt3: [1]},
            p102: {pt1: 2, pt2: [1], pt3: []}
          }},
          {number: "5.11", name: "WATER", parts: {
            p100: {pt1: 7, pt2: [1, 2, 3, 4, 5, 6, 7], pt3: [1, 2, 4, 6]},
            p101: {pt1: 1, pt2: [1], pt3: [1]},
            p102: {pt1: 18, pt2: [1, 2, 3, 4, 8, 10, 12, 16, nil, 17], pt3: []}      #####!!!!!!!!!!!!!!!!!!#####   "16.5"
          }},
          {number: "5.12", name: "LAND", parts: {
            p100: {pt1: 2, pt2: [1, 2], pt3: [1, 2]},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 4, pt2: [1, 3], pt3: []}
          }},
          {number: "5.13", name: "LAND RESTORATION", parts: {
            p100: {pt1: 4, pt2: [1, 3, 4], pt3: [1, 2, 3, 4, nil]},   #####!!!!!!!!!!!!!!!!!!#####     "5"
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }},
          {number: "5.14", name: "VISUAL AND AMBIENT IMPACTS", parts: {
            p100: {pt1: 9, pt2: [1, nil, 2, 3, 7], pt3: [11, 2, 3, 7]},     #####!!!!!!!!!!!!!!!!!!#####   "1.5" 2X
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }}]}]

    structure.each do |section|
      Section.build(section, id)
    end
    # require "pry"; binding.pry
  end
end

class Report < ApplicationRecord
after_create :build_report_sections

  has_many :sections
  has_many :sub_sections, through: :sections
  has_many :parts, through: :sub_sections

  validates :name, presence: true, uniqueness:true
  validates :company, presence: true

  enum status: [:prep, :kick_off, :document_review, :field_review, :reporting, :closed]

  def build_report_sections
    structure = [
      {section_name: "P1 Ethics", sub_sections: [
          {number: "1.1", name: "LEGAL COMPLIANCE", parts: {100 => 8, 101 => 0, 102 => 0}},
          {number: "1.2", name: "FINANCIAL DISCLOSURE", parts: {100 => 6, 101 => 0, 102 => 0}},
          {number: "1.3", name: "BRIBERY, CORRUPTION, MONEY LAUNDERING & FINANCING OF TERRORISM", parts: {100 => 4, 101 => 0, 102 => 0}},
          {number: "1.4", name: "MANAGEMENT SYSTEMS", parts: {100 => 25, 101 => 0, 102 => 1}},
          {number: "1.5", name: "CONTRACTORS", parts: {100 => 3, 101 => 0, 102 => 0}},
          {number: "1.6", name: "TRANSPARENCY & DISCLOSURE", parts: {100 => 7, 101 => 3, 102 => 2}}]},
      {section_name: "P2 Social", sub_sections: [
          {number: "2.1", name: "HUMAN RIGHTS", parts: {100 => 9, 101 => 0, 102 => 0}},
          {number: "2.2", name: "FAIR, INCLUSIVE ENGAGEMENT & GOOD FAITH CONSULTATION", parts: {100 => 20, 101 => 0, 102 => 1}},
          {number: "2.3", name: "HUMAN RIGHTS & SECURITY PERSONNEL", parts: {100 => 20, 101 => 2, 102 => 0}},
          {number: "2.4", name: "LAND RIGHTS", parts: {100 => 8, 101 => 0, 102 => 0}},
          {number: "2.5", name: "RESETTLEMENT", parts: {100 => 12, 101 => 0, 102 =>0}},
          {number: "2.6", name: "UNCONTROLLED SETTLEMENTS", parts: {100 => 4, 101 => 0, 102 => 0}},
          {number: "2.7", name: "COMMUNITY HEALTH & SAFETY", parts: {100 => 8, 101 => 0, 102 => 8}},
          {number: "2.8", name: "SUSTAINABLE COMMUNITY INVESTMENT", parts: {100 => 19, 101 => 0, 102 => 1}},
          {number: "2.9", name: "CULTURAL HERITAGE", parts: {100 => 3, 101 => 0, 102 => 0}},
          {number: "2.10", name: "GRIEVANCE MECHANISM", parts: {100 => 9, 101 => 0, 102 => 1}}]},
      {section_name: "P3 Indigenous", sub_sections: [
          {number: "3.1", name: "FREE, PRIOR & INFORMED CONSENT (FPIC)", parts: {100 => 6, 101 => 0, 102 => 3}},
          {number: "3.2", name: "ENGAGEMENT & PARTICIPATION", parts: {100 => 13, 101 => 0, 102 => 0}},
          {number: "3.3", name: "CULTURAL IMPACTS", parts: {100 => 4, 101 => 0, 102 => 0}},
          {number: "3.4", name: "USE OF TRADITIONAL NATURAL RESOURCES", parts: {100 => 3, 101 => 0, 102 => 0}},
          {number: "3.5", name: "CULTURE-BASED INTELLIGENCE & TRADITIONAL KNOWLEDGE", parts: {100 => 7, 101 => 0, 102 => 0}},
          {number: "3.6", name: "VOLUNTARY ISOLATION", parts: {100 => 4, 101 => 0, 102 => 0}}]},
      {section_name: "P4 Labor", sub_sections: [
          {number: "4.1", name: "LABOR & WORKING CONDITIONS", parts: {100 => 5, 101 => 0, 102 => 0}},
          {number: "4.2", name: "CHILD LABOR", parts: {100 => 6, 101 => 0, 102 => 0}},
          {number: "4.3", name: "FORCED LABOR", parts: {100 => 4, 101 => 0, 102 => 0}},
          {number: "4.4", name: "FREEDOM OF ASSOCIATION & COLLECTIVE BARGAINING", parts: {100 => 4, 101 => 0, 102 => 0}},
          {number: "4.5", name: "EQUAL OPPORTUNITIES & TREATMENT", parts: {100 => 8, 101 => 0, 102 => 0}},
          {number: "4.6", name: "WORKING HOURS & LEAVE", parts: {100 => 4, 101 => 0, 102 => 0}},
          {number: "4.7", name: "REMUNERATION", parts: {100 => 11, 101 => 0, 102 => 0}},
          {number: "4.8", name: "WORKPLACE GRIEVANCES", parts: {100 => 5, 101 => 0, 102 => 0}},
          {number: "4.9", name: "OCCUPATIONAL HEALTH & SAFETY", parts: {100 => 22, 101 => 0, 102 => 6}},
          {number: "4.10", name: "EMERGENCY PREPAREDNESS & RESPONSE PLANNING", parts: {100 => 9, 101 => 0, 102 => 1}}]},
      {section_name: "P5 Enviroment", sub_sections: [
          {number: "5.1", name: "ENVIRONMENTAL MANAGEMENT & MITIGATION", parts: {100 => 7, 101 => 0, 102 => 0}},
          {number: "5.2", name: "EMERGENCY PREPAREDNESS & RESPONSE PLANNING", parts: {100 => 7, 101 => 5, 102 => 1}},
          {number: "5.3", name: "ENERGY EFFICIENCY", parts: {100 => 3, 101 => 0, 102 => 0}},
          {number: "5.4", name: "WASTE PRODUCTION & MANAGEMENT", parts: {100 => 8, 101 => 1, 102 => 2}},
          {number: "5.5", name: "REMEDIATION OF ENVIRONMENTAL LIABILITIES", parts: {100 => 5, 101 => 0, 102 => 0}},
          {number: "5.6", name: "CLOSURE & RESTORATION", parts: {100 => 5, 101 => 0, 102 => 0}},
          {number: "5.7", name: "GREENHOUSE GAS EMISSIONS", parts: {100 => 11, 101 => 1, 102 => 6}},
          {number: "5.8", name: "OZONE DEPLETION", parts: {100 => 4, 101 => 0, 102 => 0}},
          {number: "5.9", name: "BIODIVERSITY & ECOLOGY", parts: {100 => 13, 101 => 0, 102 => 0}},
          {number: "5.10", name: "AIR", parts: {100 => 3, 101 => 6, 102 => 3}},
          {number: "5.11", name: "WATER", parts: {100 => 18, 101 => 3, 102 => 28}},
          {number: "5.12", name: "LAND", parts: {100 => 6, 101 => 0, 102 => 6}},
          {number: "5.13", name: "LAND RESTORATION", parts: {100 => 12, 101 => 0, 102 => 0}},
          {number: "5.14", name: "VISUAL AND AMBIENT IMPACTS", parts: {100 => 18, 101 => 0, 102 => 0}}]}]

    structure.each do |section|
      Section.build(section, id)
    end
  end
end

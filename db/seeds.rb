RelatedPart.destroy_all
Part.destroy_all
SubSection.destroy_all
Section.destroy_all
Report.destroy_all

@report1 = Report.create!(name: "Report 1", company: "Sample Company")
@report2 = Report.create!(name: "Report 2", company: "Sample Company", status: 5)
@report3 = Report.create!(name: "Report 3", company: "Sample Company")

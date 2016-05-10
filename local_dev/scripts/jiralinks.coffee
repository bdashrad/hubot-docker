# Description:
#   Automatically post jira links when issue numbers are seen
#
# Commands:
#
# Configuration:
#   none

jira_host = "https://jira.cainc.com"
#zendesk_host = "https://your.zendesk.com"

project_regex = ///
  (^|\s) # start of line or whitespace
  (AP| #list of projects
  BRIG|
  CR|
  DW|
  DFP|
  D24|
  DWA|
  TOOL|
  FL|
  FDM|
  FDR|
  FRG|
  FRPT|
  IRC|
  IRP|
  ILP|
  IMP|
  IPA|
  ISM|
  ISD|
  COPS|
  OP|
  OPSTEST|
  RA|
  SAND|
  SE|
  TBX|
  VOC|
  WWP)
  -(\d+) # '-' and issue number
  (\s|$) # space or end
///i # ignore case

module.exports = (robot) ->

  robot.hear /(^|\s)(AUP|AP|BRIG|CR|DW|DFP|D24|DWA|TOOL|FL|FDM|FDR|FRG|FRPT|IRC|IRP|ILP|IMP|IPA|ISM|ISD|COPS|OP|OPSTEST|RA|SAND|SE|TBX|VOC|WWP)-(\d+)(\s|$)/i, (msg) ->
    project = msg.match[2].toUpperCase()
    id = msg.match[3]
    issue = project + '-' + id
    url = jira_host + "/browse/" + issue
    msg.send url

#  robot.hear /z(\d+)/i, (msg) ->
#    id = msg.match[1]
#    url = zendesk_host + "/tickets/" + id
#    msg.send url

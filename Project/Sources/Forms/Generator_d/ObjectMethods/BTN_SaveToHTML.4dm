CLEANUP_IsOldStuffInstalled  //   Mod: DB (10/23/2015)

C_TEXT:C284(<>vt_ExportToResults)
<>vt_ExportToResults:="Preparing to Export all databse, project, object and form methods to html.\rScanning Methods..."

Pref_SetPrefString("HTML do Component View"; "0")
ExportDocs_SaveAsHtml

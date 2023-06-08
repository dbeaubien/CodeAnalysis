//%attributes = {"invisible":true}


//Tokenize_LineOfCode
C_TEXT:C284(Tokenize_LineOfCode; $1)
C_POINTER:C301(Tokenize_LineOfCode; $2)

//Tokenize__SplitExclusive
C_TEXT:C284(Tokenize__SplitExclusive; $1)
C_TEXT:C284(Tokenize__SplitExclusive; $2)
C_POINTER:C301(Tokenize__SplitExclusive; $3)

//STR_TrimExcessSpaces
C_TEXT:C284(STR_TrimExcessSpaces; $0)
C_TEXT:C284(STR_TrimExcessSpaces; $1)
C_POINTER:C301(Array_SetSize; ${2})
C_LONGINT:C283(Array_SetSize; $1)

//Array_ConvertFromTextDelimited
C_POINTER:C301(Array_ConvertFromTextDelimited; $1)
C_TEXT:C284(Array_ConvertFromTextDelimited; $2)
C_TEXT:C284(Array_ConvertFromTextDelimited; $3)

//DEV_ASSERT_PARMCOUNT_RANGE
C_BOOLEAN:C305(DEV_ASSERT_PARMCOUNT_RANGE; $0)
C_TEXT:C284(DEV_ASSERT_PARMCOUNT_RANGE; $1)
C_LONGINT:C283(DEV_ASSERT_PARMCOUNT_RANGE; $2)
C_LONGINT:C283(DEV_ASSERT_PARMCOUNT_RANGE; $3)
C_LONGINT:C283(DEV_ASSERT_PARMCOUNT_RANGE; $4)

//DEV_ASSERT_PARMCOUNT
C_BOOLEAN:C305(DEV_ASSERT_PARMCOUNT; $0)
C_TEXT:C284(DEV_ASSERT_PARMCOUNT; $1)
C_LONGINT:C283(DEV_ASSERT_PARMCOUNT; $2)
C_LONGINT:C283(DEV_ASSERT_PARMCOUNT; $3)

//DEV_ASSERT
C_BOOLEAN:C305(DEV_ASSERT; $0)
C_BOOLEAN:C305(DEV_ASSERT; $1)
C_TEXT:C284(DEV_ASSERT; $2)
C_TEXT:C284(DEV_ASSERT; $3)

//STR_Remove_Trailing_Spaces
C_TEXT:C284(STR_Remove_Trailing_Spaces; $0)
C_TEXT:C284(STR_Remove_Trailing_Spaces; $1)

//STR_Remove_Leading_Spaces
C_TEXT:C284(STR_Remove_Leading_Spaces; $0)
C_TEXT:C284(STR_Remove_Leading_Spaces; $1)

//Array_Empty
C_POINTER:C301(Array_Empty; $1)

//File_DoesExist
C_BOOLEAN:C305(File_DoesExist; $0)
C_TEXT:C284(File_DoesExist; $1)

//Folder_VerifyExistance
C_TEXT:C284(Folder_VerifyExistance; $1)

//Folder_ParentName
C_TEXT:C284(Folder_ParentName; $0)
C_TEXT:C284(Folder_ParentName; $1)
C_TEXT:C284(Folder_ParentName; $2)

//Folder_DoesExist
C_BOOLEAN:C305(Folder_DoesExist; $0)
C_TEXT:C284(Folder_DoesExist; $1)

//File_Delete
C_TEXT:C284(File_Delete; $1)

//Folder_EmptyContents
C_TEXT:C284(Folder_EmptyContents; $1)

//Folder_Delete
C_TEXT:C284(Folder_Delete; $1)

//MACRO_MethodBody
C_TEXT:C284(MACRO_MethodBody; $1)

//Time2String
C_TEXT:C284(Time2String; $0)
C_TIME:C306(Time2String; $1)
C_TEXT:C284(Time2String; $2)

//Date2String
C_TEXT:C284(Date2String; $0)
C_DATE:C307(Date2String; $1)
C_TEXT:C284(Date2String; $2)

//CurrentTime
C_TIME:C306(CurrentTime; $0)

//File_GetFolderName
C_TEXT:C284(File_GetFolderName; $0)
C_TEXT:C284(File_GetFolderName; $1)

//File_GetFileName
C_TEXT:C284(File_GetFileName; $0)
C_TEXT:C284(File_GetFileName; $1)

//CurrentDate
C_DATE:C307(CurrentDate; $0)

//STR_RightJustify
C_TEXT:C284(STR_RightJustify; $0)
C_TEXT:C284(STR_RightJustify; $1)
C_LONGINT:C283(STR_RightJustify; $2)

//ExportDocs__SaveMethodHtmlFiles
C_TEXT:C284(ExportDocs__SaveMethodHtmlFiles; $1)
C_LONGINT:C283(ExportDocs__SaveMethodHtmlFiles; $2)

//ExportDocs__SaveMainHtmlPage
C_TEXT:C284(ExportDocs__SaveMainHtmlPage; $1)

//MethodScan_MethodParmList_SHORT
C_TEXT:C284(MethodScan_MethodParmList_SHORT; $0)
C_TEXT:C284(MethodScan_MethodParmList_SHORT; $1)

//MethodScan_MethodParmList_LONG
C_TEXT:C284(MethodScan_MethodParmList_LONG; $0)
C_TEXT:C284(MethodScan_MethodParmList_LONG; $1)

//MethodScan_OutputMethodsAsTEXT
C_TEXT:C284(MethodScan_OutputMethodsAsTEXT; $1)
C_LONGINT:C283(MethodScan_OutputMethodsAsTEXT; $2)

//Pref_GetPrefString
C_TEXT:C284(Pref_GetPrefString; $0)
C_TEXT:C284(Pref_GetPrefString; $1)
C_TEXT:C284(Pref_GetPrefString; $2)

//Pref_SetPrefString
C_TEXT:C284(Pref_SetPrefString; $1)
C_TEXT:C284(Pref_SetPrefString; $2)

//Process_LaunchAsNew
C_BOOLEAN:C305(Process_LaunchAsNew; $0)
C_TEXT:C284(Process_LaunchAsNew; $1)
C_TEXT:C284(Process_LaunchAsNew; $2)
C_LONGINT:C283(Process_LaunchAsNew; $3)

//CodeAnalysis__GetDestFolder
C_TEXT:C284(CodeAnalysis__GetDestFolder; $0)

//Util_SaveWindowPosition
C_TEXT:C284(Util_SaveWindowPosition; $1)
C_TEXT:C284(Util_SaveWindowPosition; $2)

//WIN_CloseWindow
C_LONGINT:C283(WIN_CloseWindow; $1)
C_TEXT:C284(WIN_CloseWindow; $2)

//WIN_EnsureOnScreen
C_LONGINT:C283(WIN_EnsureOnScreen; $1)

//WIN_PositionFromDisk
C_TEXT:C284(WIN_PositionFromDisk; $1)
C_LONGINT:C283(WIN_PositionFromDisk; $2)
C_LONGINT:C283(WIN_PositionFromDisk; $3)
C_TEXT:C284(WIN_PositionFromDisk; $4)
C_TEXT:C284(WIN_PositionFromDisk; $5)

//WIN_PositionHasBeenSaved
C_BOOLEAN:C305(WIN_PositionHasBeenSaved; $0)
C_TEXT:C284(WIN_PositionHasBeenSaved; $1)
C_TEXT:C284(WIN_PositionHasBeenSaved; $2)

//WIN_Dialog
C_POINTER:C301(WIN_Dialog; $1)
C_TEXT:C284(WIN_Dialog; $2)
C_LONGINT:C283(WIN_Dialog; $3)
C_TEXT:C284(WIN_Dialog; $4)
C_LONGINT:C283(WIN_Dialog; $5)
C_LONGINT:C283(WIN_Dialog; $6)
C_BOOLEAN:C305(WIN_Dialog; $7)

//Process_WaitUntilClosed
C_LONGINT:C283(Process_WaitUntilClosed; $1)

//Process_WaitUntilOpen
C_BOOLEAN:C305(Process_WaitUntilOpen; $0)
C_LONGINT:C283(Process_WaitUntilOpen; $1)
C_LONGINT:C283(Process_WaitUntilOpen; $2)

//Pref__GetFile2PrefFile
C_TEXT:C284(Pref__GetFile2PrefFile; $0)

//STR_Base64_Encode
C_TEXT:C284(STR_Base64_Encode; $0)
C_TEXT:C284(STR_Base64_Encode; $1)

//STR_Base64_Decode
C_TEXT:C284(STR_Base64_Decode; $0)
C_TEXT:C284(STR_Base64_Decode; $1)

//MethodScan_LoadMethodNames
C_POINTER:C301(MethodScan_LoadMethodNames; $1)
C_POINTER:C301(MethodScan_LoadMethodNames; $2)

//Array_CountOccurances
C_LONGINT:C283(Array_CountOccurances; $0)
C_POINTER:C301(Array_CountOccurances; $1)
C_TEXT:C284(Array_CountOccurances; $2)

//Folder_GetAllFilePaths
C_TEXT:C284(Folder_GetAllFilePaths; $1)
C_POINTER:C301(Folder_GetAllFilePaths; $2)
C_POINTER:C301(Folder_GetAllFilePaths; $3)

//Folder_GetAllFilePaths_lvl2
C_TEXT:C284(Folder_GetAllFilePaths_lvl2; $1)
C_POINTER:C301(Folder_GetAllFilePaths_lvl2; $2)
C_POINTER:C301(Folder_GetAllFilePaths_lvl2; $3)

//CODE_doDiffOnFolder
C_COLLECTION:C1488(CODE_doDiffOnFolder; $1)

//_DIFF_ChangesText
C_TEXT:C284(_DIFF_ChangesText; $0)
C_POINTER:C301(_DIFF_ChangesText; $1)
C_POINTER:C301(_DIFF_ChangesText; $2)
C_POINTER:C301(_DIFF_ChangesText; $3)
C_POINTER:C301(_DIFF_ChangesText; $4)

//_DIFF_Diff
C_POINTER:C301(_DIFF_Diff; $1)
C_POINTER:C301(_DIFF_Diff; $2)
C_POINTER:C301(_DIFF_Diff; $3)
C_POINTER:C301(_DIFF_Diff; $4)
C_POINTER:C301(_DIFF_Diff; $5)
C_POINTER:C301(_DIFF_Diff; $6)
C_BOOLEAN:C305(_DIFF_Diff; $7)
C_BOOLEAN:C305(_DIFF_Diff; $8)

//_DIFF_DiffCode
C_POINTER:C301(_DIFF_DiffCode; $1)
C_POINTER:C301(_DIFF_DiffCode; $2)
C_BOOLEAN:C305(_DIFF_DiffCode; $3)
C_BOOLEAN:C305(_DIFF_DiffCode; $4)

//_DIFF_DiffList
C_POINTER:C301(_DIFF_DiffList; $1)
C_POINTER:C301(_DIFF_DiffList; $2)
C_POINTER:C301(_DIFF_DiffList; $3)
C_POINTER:C301(_DIFF_DiffList; $4)
C_POINTER:C301(_DIFF_DiffList; $5)
C_POINTER:C301(_DIFF_DiffList; $6)
C_POINTER:C301(_DIFF_DiffList; $7)
C_POINTER:C301(_DIFF_DiffList; $8)

//_DIFF_DiffText
C_TEXT:C284(_DIFF_DiffText; $1)
C_TEXT:C284(_DIFF_DiffText; $2)
C_POINTER:C301(_DIFF_DiffText; $3)
C_POINTER:C301(_DIFF_DiffText; $4)
C_POINTER:C301(_DIFF_DiffText; $5)
C_POINTER:C301(_DIFF_DiffText; $6)

//_DIFF_LCS
C_POINTER:C301(_DIFF_LCS; $1)
C_POINTER:C301(_DIFF_LCS; $2)
C_LONGINT:C283(_DIFF_LCS; $3)
C_LONGINT:C283(_DIFF_LCS; $4)
C_POINTER:C301(_DIFF_LCS; $5)
C_POINTER:C301(_DIFF_LCS; $6)
C_LONGINT:C283(_DIFF_LCS; $7)
C_LONGINT:C283(_DIFF_LCS; $8)
C_POINTER:C301(_DIFF_LCS; $9)
C_POINTER:C301(_DIFF_LCS; $10)

//_DIFF_Optimise
C_POINTER:C301(_DIFF_Optimise; $1)
C_POINTER:C301(_DIFF_Optimise; $2)

//_DIFF_SES
C_LONGINT:C283(_DIFF_SES; $0)
C_POINTER:C301(_DIFF_SES; $1)
C_POINTER:C301(_DIFF_SES; $2)
C_POINTER:C301(_DIFF_SES; $3)

//_DIFF_SMS
C_POINTER:C301(_DIFF_SMS; $1)
C_LONGINT:C283(_DIFF_SMS; $2)
C_LONGINT:C283(_DIFF_SMS; $3)
C_POINTER:C301(_DIFF_SMS; $4)
C_LONGINT:C283(_DIFF_SMS; $5)
C_LONGINT:C283(_DIFF_SMS; $6)
C_POINTER:C301(_DIFF_SMS; $7)
C_POINTER:C301(_DIFF_SMS; $8)
C_POINTER:C301(_DIFF_SMS; $9)
C_POINTER:C301(_DIFF_SMS; $10)

//_DIFF_Synchronise
C_POINTER:C301(_DIFF_Synchronise; $1)
C_POINTER:C301(_DIFF_Synchronise; $2)
C_POINTER:C301(_DIFF_Synchronise; $3)
C_POINTER:C301(_DIFF_Synchronise; $4)
C_POINTER:C301(_DIFF_Synchronise; $5)
C_POINTER:C301(_DIFF_Synchronise; $6)
C_POINTER:C301(_DIFF_Synchronise; $7)
C_POINTER:C301(_DIFF_Synchronise; $8)
C_POINTER:C301(_DIFF_Synchronise; $9)
C_LONGINT:C283(_DIFF_Synchronise; $10)
C_LONGINT:C283(_DIFF_Synchronise; $11)
C_LONGINT:C283(_DIFF_Synchronise; $12)

//_DIFF_TEST_DiffTestStrings
C_BOOLEAN:C305(_DIFF_TEST_DiffTestStrings; $0)
C_TEXT:C284(_DIFF_TEST_DiffTestStrings; $1)
C_TEXT:C284(_DIFF_TEST_DiffTestStrings; $2)
C_TEXT:C284(_DIFF_TEST_DiffTestStrings; $3)
C_TEXT:C284(_DIFF_TEST_DiffTestStrings; $4)

//_DIFF_TEST_GetChanges
C_TEXT:C284(_DIFF_TEST_GetChanges; $0)
C_TEXT:C284(_DIFF_TEST_GetChanges; $1)
C_TEXT:C284(_DIFF_TEST_GetChanges; $2)

//_PTR_IsArray
C_BOOLEAN:C305(_PTR_IsArray; $0)
C_POINTER:C301(_PTR_IsArray; $1)

//HASH_HashTextSDBM
C_LONGINT:C283(HASH_HashTextSDBM; $0)
C_TEXT:C284(HASH_HashTextSDBM; $1)

//ARRAY_Unpack
C_LONGINT:C283(ARRAY_Unpack; $0)
C_TEXT:C284(ARRAY_Unpack; $1)
C_POINTER:C301(ARRAY_Unpack; $2)
C_TEXT:C284(ARRAY_Unpack; $3)

//STR_TellMeTheEOL
C_TEXT:C284(STR_TellMeTheEOL; $0)
C_TEXT:C284(STR_TellMeTheEOL; $1)

//MethodScan_IndentCodeInArray
C_POINTER:C301(MethodScan_IndentCodeInArray; $1)

//Structure_GetAllFormNames
C_POINTER:C301(Structure_GetAllFormNames; $1)
C_POINTER:C301(Structure_GetAllFormNames; $2)

//MethodCode_RemoveAttributeLine
C_TEXT:C284(MethodCode_RemoveAttributeLine; $0)
C_TEXT:C284(MethodCode_RemoveAttributeLine; $1)

//MethodCode_RemoveAllComments
C_TEXT:C284(MethodCode_RemoveAllComments; $0)
C_TEXT:C284(MethodCode_RemoveAllComments; $1)

//Array_ConvertToTextDelimited
C_TEXT:C284(Array_ConvertToTextDelimited; $0)
C_POINTER:C301(Array_ConvertToTextDelimited; $1)
C_TEXT:C284(Array_ConvertToTextDelimited; $2)

//MethodCode_RemoveBlankLines
C_TEXT:C284(MethodCode_RemoveBlankLines; $0)
C_TEXT:C284(MethodCode_RemoveBlankLines; $1)

//File_GetExtension
C_TEXT:C284(File_GetExtension; $0)
C_TEXT:C284(File_GetExtension; $1)

//File_DeriveFileTypeFromName
C_TEXT:C284(File_DeriveFileTypeFromName; $0)
C_TEXT:C284(File_DeriveFileTypeFromName; $1)

//File_CreateFile
C_TIME:C306(File_CreateFile; $0)
C_TEXT:C284(File_CreateFile; $1)
C_TEXT:C284(File_CreateFile; $2)
C_POINTER:C301(File_ExportArrays2CSV; ${3})
C_TEXT:C284(File_ExportArrays2CSV; $1)
C_POINTER:C301(File_ExportArrays2CSV; $2)

//Boolean2String
C_TEXT:C284(Boolean2String; $0)
C_BOOLEAN:C305(Boolean2String; $1)
C_TEXT:C284(Boolean2String; $2)
C_TEXT:C284(Boolean2String; $3)

//Component_DocDialog
C_LONGINT:C283(Component_DocDialog; $1)

//ExportDocs___Output_All_NavHTML
C_TEXT:C284(ExportDocs___Output_All_NavHTML; $0)

//ExportDocs___Output_PM_NavHTML
C_TEXT:C284(ExportDocs___Output_PM_NavHTML; $0)
C_LONGINT:C283(ExportDocs___Output_PM_NavHTML; $1)
C_BOOLEAN:C305(ExportDocs___Output_PM_NavHTML; $2)
C_BOOLEAN:C305(ExportDocs___Output_PM_NavHTML; $3)

//ExportDocs___Output_PF_NavHTML
C_TEXT:C284(ExportDocs___Output_PF_NavHTML; $0)
C_LONGINT:C283(ExportDocs___Output_PF_NavHTML; $1)

//MethodScan_CountThatMatchPattrn
C_LONGINT:C283(MethodScan_CountThatMatchPattrn; $0)
C_TEXT:C284(MethodScan_CountThatMatchPattrn; $1)

//ExportDocs___Output_DM_NavHTML
C_TEXT:C284(ExportDocs___Output_DM_NavHTML; $0)
C_LONGINT:C283(ExportDocs___Output_DM_NavHTML; $1)

//ExportDocs___Output_TM_NavHTML
C_TEXT:C284(ExportDocs___Output_TM_NavHTML; $0)
C_LONGINT:C283(ExportDocs___Output_TM_NavHTML; $1)

//Folder_Copy
C_TEXT:C284(Folder_Copy; $1)
C_TEXT:C284(Folder_Copy; $2)
C_COLLECTION:C1488(Folder_Copy; $3)

//OnErr_GetLastError
C_LONGINT:C283(OnErr_GetLastError; $0)

//STR_SeparateOnCapitals
C_TEXT:C284(STR_SeparateOnCapitals; $0)
C_TEXT:C284(STR_SeparateOnCapitals; $1)

//ExportDocs___Output_TF_NavHTML
C_TEXT:C284(ExportDocs___Output_TF_NavHTML; $0)
C_LONGINT:C283(ExportDocs___Output_TF_NavHTML; $1)

//MethodDiff_d_ApplyCodePrefs
C_TEXT:C284(MethodDiff_d_ApplyCodePrefs; $0)
C_TEXT:C284(MethodDiff_d_ApplyCodePrefs; $1)

//MethodDiff_d_CalcNumChanges
C_LONGINT:C283(MethodDiff_d_CalcNumChanges; $0)
C_POINTER:C301(MethodDiff_d_CalcNumChanges; $1)

//FormProperties_SaveToFile
C_LONGINT:C283(FormProperties_SaveToFile; $1)
C_TEXT:C284(FormProperties_SaveToFile; $2)
C_TEXT:C284(FormProperties_SaveToFile; $3)

//Host_VerifyMethodExists
C_TEXT:C284(Host_VerifyMethodExists; $1)
C_BOOLEAN:C305(Host_VerifyMethodExists; $2)

//STR_LongintToHexString
C_TEXT:C284(STR_LongintToHexString; $0)
C_LONGINT:C283(STR_LongintToHexString; $1)
C_LONGINT:C283(STR_LongintToHexString; $2)

//CA_SaveFormProperties
C_BOOLEAN:C305(CA_SaveFormProperties; $0)
C_LONGINT:C283(CA_SaveFormProperties; $1)
C_TEXT:C284(CA_SaveFormProperties; $2)
C_TEXT:C284(CA_SaveFormProperties; $3)

//CA_SaveMethodsToTextFiles
C_TEXT:C284(CA_SaveMethodsToTextFiles; $1)

//JSON_EncodeString
C_TEXT:C284(JSON_EncodeString; $0)
C_TEXT:C284(JSON_EncodeString; $1)
C_TEXT:C284(JSON_EncodeString; $2)

//Method_FixSpecialCharacters
C_POINTER:C301(Method_FixSpecialCharacters; $1)

//STR_URLDecode
C_TEXT:C284(STR_URLDecode; $0)
C_TEXT:C284(STR_URLDecode; $1)

//STR_URLEncode
C_TEXT:C284(STR_URLEncode; $0)
C_TEXT:C284(STR_URLEncode; $1)

//File_MakeNameWindowsSafe
C_TEXT:C284(File_MakeNameWindowsSafe; $0)
C_TEXT:C284(File_MakeNameWindowsSafe; $1)

//Spell_GetPathToUserDictationary
C_TEXT:C284(Spell_GetPathToUserDictationary; $0)

//4D_GenerateDigest
C_TEXT:C284(4D_GenerateDigest; $0)
C_TEXT:C284(4D_GenerateDigest; $1)

//CodeAnalysis_GetAssetInfoCOPY
C_TEXT:C284(CodeAnalysis_GetAssetInfoCOPY; $1)
C_POINTER:C301(CodeAnalysis_GetAssetInfoCOPY; $2)
C_POINTER:C301(CodeAnalysis_GetAssetInfoCOPY; $3)

//Host_GetAssetInfo_GetTableForms
C_LONGINT:C283(Host_GetAssetInfo_GetTableForms; $1)
C_POINTER:C301(Host_GetAssetInfo_GetTableForms; $2)

//Host_GetAssetInfo_GetProjForms
C_POINTER:C301(Host_GetAssetInfo_GetProjForms; $1)

//Host_GetAssetInfo_GetFormProp
C_LONGINT:C283(Host_GetAssetInfo_GetFormProp; $1)
C_TEXT:C284(Host_GetAssetInfo_GetFormProp; $2)
C_POINTER:C301(Host_GetAssetInfo_GetFormProp; $3)
C_POINTER:C301(Host_GetAssetInfo_GetFormProp; $4)
C_POINTER:C301(Host_GetAssetInfo_GetFormProp; $5)
C_POINTER:C301(Host_GetAssetInfo_GetFormProp; $6)
C_POINTER:C301(Host_GetAssetInfo_GetFormProp; $7)
C_POINTER:C301(Host_GetAssetInfo_GetFormProp; $8)

//Structure_SaveStructDefn2Folder
C_TEXT:C284(Structure_SaveStructDefn2Folder; $1)

//UTF8_BOMString
C_BLOB:C604(UTF8_BOMString; $0)

//Structure__DataType2String
C_TEXT:C284(Structure__DataType2String; $0)
C_LONGINT:C283(Structure__DataType2String; $1)
C_BOOLEAN:C305(Structure__DataType2String; $2)

//POSIX_of_FilePath
C_TEXT:C284(POSIX_of_FilePath; $0)
C_TEXT:C284(POSIX_of_FilePath; $1)

//Sqlite_DoCommand
C_TEXT:C284(Sqlite_DoCommand; $0)
C_TEXT:C284(Sqlite_DoCommand; $1)
C_TEXT:C284(Sqlite_DoCommand; $2)

//ExportDocs___OutputModuleAsHTML
C_TEXT:C284(ExportDocs___OutputModuleAsHTML; $1)
C_LONGINT:C283(ExportDocs___OutputModuleAsHTML; $2)

//Structure__SQLDataType2String
C_TEXT:C284(Structure__SQLDataType2String; $0)
C_LONGINT:C283(Structure__SQLDataType2String; $1)

//Structure_IndexType2Name
C_TEXT:C284(Structure_IndexType2Name; $0)
C_LONGINT:C283(Structure_IndexType2Name; $1)

//OnErr_Message
C_TEXT:C284(OnErr_Message; $0)

//Utility_MakeTextStyleSafe
C_TEXT:C284(Utility_MakeTextStyleSafe; $0)
C_TEXT:C284(Utility_MakeTextStyleSafe; $1)

//Method_GetNormalizedCode
C_TEXT:C284(Method_GetNormalizedCode; $0)
C_TEXT:C284(Method_GetNormalizedCode; $1)
C_BOOLEAN:C305(Method_GetNormalizedCode; $2)

//Pref_GetEOL
C_TEXT:C284(Pref_GetEOL; $0)

//Pref_SetEOL
C_TEXT:C284(Pref_SetEOL; $1)

//Pref__GetFile2GlobalPrefFile
C_TEXT:C284(Pref__GetFile2GlobalPrefFile; $0)

//Pref_GetGlobalPrefString
C_TEXT:C284(Pref_GetGlobalPrefString; $0)
C_TEXT:C284(Pref_GetGlobalPrefString; $1)
C_TEXT:C284(Pref_GetGlobalPrefString; $2)

//Pref_SetGlobalPrefString
C_TEXT:C284(Pref_SetGlobalPrefString; $1)
C_TEXT:C284(Pref_SetGlobalPrefString; $2)

//Pref__GetFile2PrefFile_OLD
C_TEXT:C284(Pref__GetFile2PrefFile_OLD; $0)

//Method_LoadFromFile
C_LONGINT:C283(Method_LoadFromFile; $0)
C_TEXT:C284(Method_LoadFromFile; $1)
C_TEXT:C284(Method_LoadFromFile; $2)

//Folder_MakePathRelativeToStruct
C_TEXT:C284(Folder_MakePathRelativeToStruct; $0)
C_TEXT:C284(Folder_MakePathRelativeToStruct; $1)

//Pref_SetPrefTextArray
C_TEXT:C284(Pref_SetPrefTextArray; $1)
C_POINTER:C301(Pref_SetPrefTextArray; $2)

//Pref_GetPrefTextArray
C_TEXT:C284(Pref_GetPrefTextArray; $1)
C_POINTER:C301(Pref_GetPrefTextArray; $2)

//Folder_GetPathFrmRelativeToStct
C_TEXT:C284(Folder_GetPathFrmRelativeToStct; $0)
C_TEXT:C284(Folder_GetPathFrmRelativeToStct; $1)

//CA_SaveExtraFolders
C_TEXT:C284(CA_SaveExtraFolders; $1)

//TS_FromDateTime
C_LONGINT:C283(TS_FromDateTime; $0)
C_DATE:C307(TS_FromDateTime; $1)
C_TIME:C306(TS_FromDateTime; $2)

//Digest_GetForMethod
C_TEXT:C284(Digest_GetForMethod; $0)
C_TEXT:C284(Digest_GetForMethod; $1)
C_BOOLEAN:C305(Digest_GetForMethod; $2)
C_BOOLEAN:C305(Digest_GetForMethod; $3)
C_BOOLEAN:C305(Digest_GetForMethod; $4)
C_BOOLEAN:C305(Digest_GetForMethod; $5)

//Digest_GetForFile
C_TEXT:C284(Digest_GetForFile; $0)
C_TEXT:C284(Digest_GetForFile; $1)
C_BOOLEAN:C305(Digest_GetForFile; $2)
C_BOOLEAN:C305(Digest_GetForFile; $3)
C_BOOLEAN:C305(Digest_GetForFile; $4)
C_BOOLEAN:C305(Digest_GetForFile; $5)

//Folder_isWritable
C_BOOLEAN:C305(Folder_isWritable; $0)
C_TEXT:C284(Folder_isWritable; $1)

//CHART_SVG_GetMasterRef
C_TEXT:C284(CHART_SVG_GetMasterRef; $0)
C_TEXT:C284(CHART_SVG_GetMasterRef; $1)

//CHART_SVG_GetGridRef
C_TEXT:C284(CHART_SVG_GetGridRef; $0)
C_TEXT:C284(CHART_SVG_GetGridRef; $1)

//CHART_SaveAsSVG
C_TEXT:C284(CHART_SaveAsSVG; $1)
C_TEXT:C284(CHART_SaveAsSVG; $2)

//CHART_SaveAsPNG
C_TEXT:C284(CHART_SaveAsPNG; $1)
C_TEXT:C284(CHART_SaveAsPNG; $2)

//CHART_SaveAsJPG
C_TEXT:C284(CHART_SaveAsJPG; $1)
C_TEXT:C284(CHART_SaveAsJPG; $2)

//CHART_SaveAsGIF
C_TEXT:C284(CHART_SaveAsGIF; $1)
C_TEXT:C284(CHART_SaveAsGIF; $2)

//CHART_Line_SetSeriesLabel
C_TEXT:C284(CHART_Line_SetSeriesLabel; $1)
C_TEXT:C284(CHART_Line_SetSeriesLabel; $2)

//CHART_Line_SetPointIndicator
C_TEXT:C284(CHART_Line_SetPointIndicator; $1)
C_TEXT:C284(CHART_Line_SetPointIndicator; $2)
C_LONGINT:C283(CHART_Line_SetPointIndicator; $3)
C_TEXT:C284(CHART_Line_SetPointIndicator; $4)

//CHART_Line_AddTrendline
C_TEXT:C284(CHART_Line_AddTrendline; $1)
C_LONGINT:C283(CHART_Line_AddTrendline; $2)
C_LONGINT:C283(CHART_Line_AddTrendline; $3)
C_TEXT:C284(CHART_Line_AddTrendline; $4)

//CHART_Line_AddDatedValues
C_TEXT:C284(CHART_Line_AddDatedValues; $1)
C_POINTER:C301(CHART_Line_AddDatedValues; $2)
C_POINTER:C301(CHART_Line_AddDatedValues; $3)
C_TEXT:C284(CHART_Line_AddDatedValues; $4)

//CHART_Draw
C_TEXT:C284(CHART_Draw; $1)

//CHART_CreateNewGraph
C_TEXT:C284(CHART_CreateNewGraph; $0)
C_LONGINT:C283(CHART_CreateNewGraph; $1)
C_LONGINT:C283(CHART_CreateNewGraph; $2)
C_TEXT:C284(CHART_CreateNewGraph; $3)

//CHART_Config_YAxis_SetMinMax
C_TEXT:C284(CHART_Config_YAxis_SetMinMax; $1)
C_LONGINT:C283(CHART_Config_YAxis_SetMinMax; $2)
C_LONGINT:C283(CHART_Config_YAxis_SetMinMax; $3)

//CHART_Config_YAxis_SetIncrement
C_TEXT:C284(CHART_Config_YAxis_SetIncrement; $1)
C_REAL:C285(CHART_Config_YAxis_SetIncrement; $2)

//CHART_Config_ShowSeriesLabels
C_TEXT:C284(CHART_Config_ShowSeriesLabels; $1)
C_BOOLEAN:C305(CHART_Config_ShowSeriesLabels; $2)
C_LONGINT:C283(CHART_Config_ShowSeriesLabels; $3)

//CHART_Config_SetHorzDateFormat
C_TEXT:C284(CHART_Config_SetHorzDateFormat; $1)
C_TEXT:C284(CHART_Config_SetHorzDateFormat; $2)

//CHART_Clear
C_TEXT:C284(CHART_Clear; $1)

//CHART_Area_SetSeriesLabel
C_TEXT:C284(CHART_Area_SetSeriesLabel; $1)
C_TEXT:C284(CHART_Area_SetSeriesLabel; $2)

//CHART_Area_SetPointIndicator
C_TEXT:C284(CHART_Area_SetPointIndicator; $1)
C_TEXT:C284(CHART_Area_SetPointIndicator; $2)
C_LONGINT:C283(CHART_Area_SetPointIndicator; $3)
C_TEXT:C284(CHART_Area_SetPointIndicator; $4)

//CHART_Area_AddDatedValues
C_TEXT:C284(CHART_Area_AddDatedValues; $1)
C_POINTER:C301(CHART_Area_AddDatedValues; $2)
C_POINTER:C301(CHART_Area_AddDatedValues; $3)
C_TEXT:C284(CHART_Area_AddDatedValues; $4)

//CHART__Draw_Indicator
C_TEXT:C284(CHART__Draw_Indicator; $1)
C_LONGINT:C283(CHART__Draw_Indicator; $2)
C_LONGINT:C283(CHART__Draw_Indicator; $3)
C_TEXT:C284(CHART__Draw_Indicator; $4)
C_LONGINT:C283(CHART__Draw_Indicator; $5)
C_TEXT:C284(CHART__Draw_Indicator; $6)

//CHART__Draw_GridBox
C_TEXT:C284(CHART__Draw_GridBox; $1)
C_LONGINT:C283(CHART__Draw_GridBox; $2)
C_TEXT:C284(CHART__Draw_GridBox; $3)

//NUM_GetMinLong
C_LONGINT:C283(NUM_GetMinLong; $0)
C_LONGINT:C283(NUM_GetMinLong; $1)
C_LONGINT:C283(NUM_GetMinLong; $2)

//NUM_GetMaxReal
C_REAL:C285(NUM_GetMaxReal; $0)
C_REAL:C285(NUM_GetMaxReal; $1)
C_REAL:C285(NUM_GetMaxReal; $2)

//NUM_GetMinReal
C_REAL:C285(NUM_GetMinReal; $0)
C_REAL:C285(NUM_GetMinReal; $1)
C_REAL:C285(NUM_GetMinReal; $2)

//OT_Clear
C_TEXT:C284(OT_Clear; $1)

//OT_New
C_TEXT:C284(OT_New; $0)

//OT_PutText
C_TEXT:C284(OT_PutText; $1)
C_TEXT:C284(OT_PutText; $2)
C_TEXT:C284(OT_PutText; $3)

//OT_PutLong
C_TEXT:C284(OT_PutLong; $1)
C_TEXT:C284(OT_PutLong; $2)
C_LONGINT:C283(OT_PutLong; $3)

//OT_GetLong
C_LONGINT:C283(OT_GetLong; $0)
C_TEXT:C284(OT_GetLong; $1)
C_TEXT:C284(OT_GetLong; $2)

//OT_GetText
C_TEXT:C284(OT_GetText; $0)
C_TEXT:C284(OT_GetText; $1)
C_TEXT:C284(OT_GetText; $2)

//OT_PutArray
C_TEXT:C284(OT_PutArray; $1)
C_TEXT:C284(OT_PutArray; $2)
C_POINTER:C301(OT_PutArray; $3)

//OT_GetArray
C_TEXT:C284(OT_GetArray; $1)
C_TEXT:C284(OT_GetArray; $2)
C_POINTER:C301(OT_GetArray; $3)

//OT_GetReal
C_REAL:C285(OT_GetReal; $0)
C_TEXT:C284(OT_GetReal; $1)
C_TEXT:C284(OT_GetReal; $2)

//OT_PutReal
C_TEXT:C284(OT_PutReal; $1)
C_TEXT:C284(OT_PutReal; $2)
C_REAL:C285(OT_PutReal; $3)

//CHART_Config_XAxis_SetDataType
C_TEXT:C284(CHART_Config_XAxis_SetDataType; $1)
C_LONGINT:C283(CHART_Config_XAxis_SetDataType; $2)

//CHART_Area_AddNumberedValues
C_TEXT:C284(CHART_Area_AddNumberedValues; $1)
C_POINTER:C301(CHART_Area_AddNumberedValues; $2)
C_POINTER:C301(CHART_Area_AddNumberedValues; $3)
C_TEXT:C284(CHART_Area_AddNumberedValues; $4)

//CHART_Line_AddNumberedValues
C_TEXT:C284(CHART_Line_AddNumberedValues; $1)
C_POINTER:C301(CHART_Line_AddNumberedValues; $2)
C_POINTER:C301(CHART_Line_AddNumberedValues; $3)
C_TEXT:C284(CHART_Line_AddNumberedValues; $4)

//NUM_GetMaxLong
C_LONGINT:C283(NUM_GetMaxLong; $0)
C_LONGINT:C283(NUM_GetMaxLong; $1)
C_LONGINT:C283(NUM_GetMaxLong; $2)

//Array_SaveToFile
C_LONGINT:C283(Array_SaveToFile; $0)
C_POINTER:C301(Array_SaveToFile; $1)
C_TEXT:C284(Array_SaveToFile; $2)

//Array_LoadFromFile
C_LONGINT:C283(Array_LoadFromFile; $0)
C_POINTER:C301(Array_LoadFromFile; $1)
C_TEXT:C284(Array_LoadFromFile; $2)

//MethodScan__StripCompilerMeths
C_POINTER:C301(MethodScan__StripCompilerMeths; $1)

//Methods_GetNamesAndDTS
C_POINTER:C301(Methods_GetNamesAndDTS; $1)
C_POINTER:C301(Methods_GetNamesAndDTS; $2)

//MethodStats__Init
C_BOOLEAN:C305(MethodStats__Init; $1)

//MethodStats__AddMethod
C_LONGINT:C283(MethodStats__AddMethod; $0)
C_TEXT:C284(MethodStats__AddMethod; $1)

//MethodStats__DeleteMethod
C_LONGINT:C283(MethodStats__DeleteMethod; $0)
C_TEXT:C284(MethodStats__DeleteMethod; $1)

//Array_Sum
C_LONGINT:C283(Array_Sum; $0)
C_POINTER:C301(Array_Sum; $1)

//MethodStats__GatherParmInfo
C_POINTER:C301(MethodStats__GatherParmInfo; $1)
C_POINTER:C301(MethodStats__GatherParmInfo; $2)
C_POINTER:C301(MethodStats__GatherParmInfo; $3)

//MethodStats__GatherParmInfo2
C_POINTER:C301(MethodStats__GatherParmInfo2; $1)
C_TEXT:C284(MethodStats__GatherParmInfo2; $2)
C_TEXT:C284(MethodStats__GatherParmInfo2; $3)
C_TEXT:C284(MethodStats__GatherParmInfo2; $4)
C_TEXT:C284(MethodStats__GatherParmInfo2; $5)

//Methods_GetNames
C_POINTER:C301(Methods_GetNames; $1)

//LogEvent_Write
C_TEXT:C284(LogEvent_Write; $1)
C_TEXT:C284(LogEvent_Write; $2)

//Semaphore_WaitUntilGrabbed
C_TEXT:C284(Semaphore_WaitUntilGrabbed; $1)
C_LONGINT:C283(Semaphore_WaitUntilGrabbed; $2)

//Semaphore_Release
C_TEXT:C284(Semaphore_Release; $1)

//LogEvent_GetLogFolder
C_TEXT:C284(LogEvent_GetLogFolder; $0)

//LogEvent_SetLogFolder
C_TEXT:C284(LogEvent_SetLogFolder; $1)

//LogEvent_GetPathToLogFile
C_TEXT:C284(LogEvent_GetPathToLogFile; $0)
C_TEXT:C284(LogEvent_GetPathToLogFile; $1)

//DateTime_GetYearWeekNr
C_TEXT:C284(DateTime_GetYearWeekNr; $0)
C_DATE:C307(DateTime_GetYearWeekNr; $1)
C_TEXT:C284(DateTime_GetYearWeekNr; $2)

//LogEvent_SetNewLogFrequency
C_TEXT:C284(LogEvent_SetNewLogFrequency; $1)

//STR_IsOneOf
C_BOOLEAN:C305(STR_IsOneOf; $0)
C_TEXT:C284(STR_IsOneOf; ${2})
C_TEXT:C284(STR_IsOneOf; $1)

//DEV_Get_QueryCommandsArray
C_POINTER:C301(DEV_Get_QueryCommandsArray; $1)
C_POINTER:C301(DEV_Get_QueryCommandsArray; $2)

//AnalysisGraph_GetTemplate
C_TEXT:C284(AnalysisGraph_GetTemplate; $0)

//Generator__SetPage
C_LONGINT:C283(Generator__SetPage; $1)
C_LONGINT:C283(Generator__SetPage; $2)

//Structure_GetFieldIndexType
C_LONGINT:C283(Structure_GetFieldIndexType; $0)
C_LONGINT:C283(Structure_GetFieldIndexType; $1)
C_LONGINT:C283(Structure_GetFieldIndexType; $2)

//Structure_GetFieldIndexRatio
C_REAL:C285(Structure_GetFieldIndexRatio; $0)
C_LONGINT:C283(Structure_GetFieldIndexRatio; $1)
C_LONGINT:C283(Structure_GetFieldIndexRatio; $2)

//Digest_GetForMethodText
C_TEXT:C284(Digest_GetForMethodText; $0)
C_TEXT:C284(Digest_GetForMethodText; $1)
C_BOOLEAN:C305(Digest_GetForMethodText; $2)
C_BOOLEAN:C305(Digest_GetForMethodText; $3)
C_BOOLEAN:C305(Digest_GetForMethodText; $4)
C_BOOLEAN:C305(Digest_GetForMethodText; $5)

//CODE_PreLoadProcessVarsArrs
C_TEXT:C284(CODE_PreLoadProcessVarsArrs; $0)
C_LONGINT:C283(CODE_PreLoadProcessVarsArrs; $1)

//Method_GetCompilerMthdNmsAndDTS
C_POINTER:C301(Method_GetCompilerMthdNmsAndDTS; $1)
C_POINTER:C301(Method_GetCompilerMthdNmsAndDTS; $2)

//Structure_GetTokenArr_Cdefn
C_POINTER:C301(Structure_GetTokenArr_Cdefn; $1)

//Structure_GetTokenArr_ArrDefn
C_POINTER:C301(Structure_GetTokenArr_ArrDefn; $1)

//Method_GetCalledByMethods
C_OBJECT:C1216(Method_GetCalledByMethods; $0)
C_TEXT:C284(Method_GetCalledByMethods; $1)

//Method_GetMethodsCalled
C_OBJECT:C1216(Method_GetMethodsCalled; $0)
C_TEXT:C284(Method_GetMethodsCalled; $1)

//CA_GetMethodsCalledByMethod
C_OBJECT:C1216(CA_GetMethodsCalledByMethod; $0)
C_TEXT:C284(CA_GetMethodsCalledByMethod; $1)

//CA_GetMethodsCallingTheMethod
C_OBJECT:C1216(CA_GetMethodsCallingTheMethod; $0)
C_TEXT:C284(CA_GetMethodsCallingTheMethod; $1)

//MethodStats_IsLineIndent
C_BOOLEAN:C305(MethodStats_IsLineIndent; $0)
C_TEXT:C284(MethodStats_IsLineIndent; $1)

//MethodStats_IsLineOutdent
C_BOOLEAN:C305(MethodStats_IsLineOutdent; $0)
C_TEXT:C284(MethodStats_IsLineOutdent; $1)

//MethodStats__GetMaxNestingLevel
C_LONGINT:C283(MethodStats__GetMaxNestingLevel; $0)
C_POINTER:C301(MethodStats__GetMaxNestingLevel; $1)

//List_Object_SetStyle
C_TEXT:C284(List_Object_SetStyle; $1)
C_LONGINT:C283(List_Object_SetStyle; $2)
C_LONGINT:C283(List_Object_SetStyle; $3)

//TS_GetDate
C_DATE:C307(TS_GetDate; $0)
C_LONGINT:C283(TS_GetDate; $1)

//TS_GetTime
C_TIME:C306(TS_GetTime; $0)
C_LONGINT:C283(TS_GetTime; $1)

//Pic_make_4stateIcon
C_PICTURE:C286(Pic_make_4stateIcon; $0)
C_PICTURE:C286(Pic_make_4stateIcon; $1)
C_LONGINT:C283(Pic_make_4stateIcon; $2)

//Explorer_ApplyMethodFilter
C_OBJECT:C1216(Explorer_ApplyMethodFilter; $1)

//CodeReview_LoadMethod
C_TEXT:C284(CodeReview_LoadMethod; $1)

//CodeReview_LoadAndScanVars
C_TEXT:C284(CodeReview_LoadAndScanVars; $0)
C_LONGINT:C283(CodeReview_LoadAndScanVars; $1)

//Logging_Method_START
C_TEXT:C284(Logging_Method_START; $1)
C_TEXT:C284(Logging_Method_START; $2)

//Logging_Method__init
C_BOOLEAN:C305(Logging_Method__init; $1)

//Logging_Method_STOP
C_TEXT:C284(Logging_Method_STOP; $1)
C_TEXT:C284(Logging_Method_STOP; $2)

//Tokenize__Init
C_BOOLEAN:C305(Tokenize__Init; $1)

//Str_DateTimeStamp
C_TEXT:C284(Str_DateTimeStamp; $0)

//Array_FindInSortedArray
C_BOOLEAN:C305(Array_FindInSortedArray; $0)
C_POINTER:C301(Array_FindInSortedArray; $1)
C_POINTER:C301(Array_FindInSortedArray; $2)
C_POINTER:C301(Array_FindInSortedArray; $3)

//Component_DocDialog_SetTab
C_LONGINT:C283(Component_DocDialog_SetTab; $1)

//CA_Pref_GetPreferencesFolder
C_TEXT:C284(CA_Pref_GetPreferencesFolder; $0)

//CA_Pref_GetStructureKey
C_TEXT:C284(CA_Pref_GetStructureKey; $0)

//CA_Pref_SetStructureKey
C_TEXT:C284(CA_Pref_SetStructureKey; $1)

//CA_Pref_SetExportFolder
C_TEXT:C284(CA_Pref_SetExportFolder; $1)

//CA_Pref_SetEOL
C_TEXT:C284(CA_Pref_SetEOL; $1)

//Tokenize_LineOfCode_AddToArrays
C_POINTER:C301(Tokenize_LineOfCode_AddToArrays; $1)
C_TEXT:C284(Tokenize_LineOfCode_AddToArrays; $2)
C_TEXT:C284(Tokenize_LineOfCode_AddToArrays; $3)

//CyclomaticComplexity_CalcInc
C_LONGINT:C283(CyclomaticComplexity_CalcInc; $0)
C_POINTER:C301(CyclomaticComplexity_CalcInc; $1)

//UnitTest_SaveStats
C_TEXT:C284(UnitTest_SaveStats; $1)

//UnitTest_SaveLog
C_TEXT:C284(UnitTest_SaveLog; $1)

//UnitTest_RunTestCase
C_TEXT:C284(UnitTest_RunTestCase; $1)

//UnitTest_RunTest
C_TEXT:C284(UnitTest_RunTest; $1)

//UnitTest_LogMessage
C_TEXT:C284(UnitTest_LogMessage; $1)

//UnitTest_Init
C_TEXT:C284(UnitTest_Init; $1)

//UnitTest_AssertTrue
C_BOOLEAN:C305(UnitTest_AssertTrue; $1)
C_TEXT:C284(UnitTest_AssertTrue; $2)

//UnitTest_AssertRecordCount
C_LONGINT:C283(UnitTest_AssertRecordCount; $1)
C_POINTER:C301(UnitTest_AssertRecordCount; $2)
C_TEXT:C284(UnitTest_AssertRecordCount; $3)

//UnitTest_AssertNotNil
C_POINTER:C301(UnitTest_AssertNotNil; $1)
C_TEXT:C284(UnitTest_AssertNotNil; $2)

//UnitTest_AssertNil
C_POINTER:C301(UnitTest_AssertNil; $1)
C_TEXT:C284(UnitTest_AssertNil; $2)

//UnitTest_AssertFolderExists
C_TEXT:C284(UnitTest_AssertFolderExists; $1)
C_TEXT:C284(UnitTest_AssertFolderExists; $2)

//UnitTest_AssertFileExists
C_TEXT:C284(UnitTest_AssertFileExists; $1)
C_TEXT:C284(UnitTest_AssertFileExists; $2)

//UnitTest_AssertFalse
C_BOOLEAN:C305(UnitTest_AssertFalse; $1)
C_TEXT:C284(UnitTest_AssertFalse; $2)

//UnitTest_AssertEqualTime
C_TIME:C306(UnitTest_AssertEqualTime; $1)
C_TIME:C306(UnitTest_AssertEqualTime; $2)
C_TEXT:C284(UnitTest_AssertEqualTime; $3)

//UnitTest_AssertEqualTextAndCase
C_TEXT:C284(UnitTest_AssertEqualTextAndCase; $1)
C_TEXT:C284(UnitTest_AssertEqualTextAndCase; $2)
C_TEXT:C284(UnitTest_AssertEqualTextAndCase; $3)

//UnitTest_AssertEqualText
C_TEXT:C284(UnitTest_AssertEqualText; $1)
C_TEXT:C284(UnitTest_AssertEqualText; $2)
C_TEXT:C284(UnitTest_AssertEqualText; $3)

//UnitTest_AssertEqualReal
C_REAL:C285(UnitTest_AssertEqualReal; $1)
C_REAL:C285(UnitTest_AssertEqualReal; $2)
C_TEXT:C284(UnitTest_AssertEqualReal; $3)

//UnitTest_AssertEqualPointer
C_POINTER:C301(UnitTest_AssertEqualPointer; $1)
C_POINTER:C301(UnitTest_AssertEqualPointer; $2)
C_TEXT:C284(UnitTest_AssertEqualPointer; $3)

//UnitTest_AssertEqualLongint
C_LONGINT:C283(UnitTest_AssertEqualLongint; $1)
C_LONGINT:C283(UnitTest_AssertEqualLongint; $2)
C_TEXT:C284(UnitTest_AssertEqualLongint; $3)

//UnitTest_AssertEqualDate
C_DATE:C307(UnitTest_AssertEqualDate; $1)
C_DATE:C307(UnitTest_AssertEqualDate; $2)
C_TEXT:C284(UnitTest_AssertEqualDate; $3)

//UnitTest_AssertEqualArray
C_POINTER:C301(UnitTest_AssertEqualArray; $1)
C_POINTER:C301(UnitTest_AssertEqualArray; $2)
C_TEXT:C284(UnitTest_AssertEqualArray; $3)

//UnitTest_AssertArraySize
C_LONGINT:C283(UnitTest_AssertArraySize; $1)
C_POINTER:C301(UnitTest_AssertArraySize; $2)
C_TEXT:C284(UnitTest_AssertArraySize; $3)

//UnitTest_Assert
C_BOOLEAN:C305(UnitTest_Assert; $1)
C_TEXT:C284(UnitTest_Assert; $2)

//UnitTest_AddTestCase
C_TEXT:C284(UnitTest_AddTestCase; $1)

//UnitTest__Stopwatch
C_TEXT:C284(UnitTest__Stopwatch; $1)

//UnitTest__ResolvePointer
C_TEXT:C284(UnitTest__ResolvePointer; $0)
C_POINTER:C301(UnitTest__ResolvePointer; $1)

//Date__UnitTests
C_TEXT:C284(Date__UnitTests; $1)

//File__UnitTests
C_TEXT:C284(File__UnitTests; $1)

//NUM__UnitTests
C_TEXT:C284(NUM__UnitTests; $1)

//STR__UnitTests
C_TEXT:C284(STR__UnitTests; $1)

//Tokenize__UnitTests
C_TEXT:C284(Tokenize__UnitTests; $1)

//CyclomaticComplxty_UnitTests
C_TEXT:C284(CyclomaticComplxty_UnitTests; $1)

//_DIFF__UnitTests
C_TEXT:C284(_DIFF__UnitTests; $1)

//MethodStats__UnitTests
C_TEXT:C284(MethodStats__UnitTests; $1)

//MethodStats__GetPosOfFieldRef
C_LONGINT:C283(MethodStats__GetPosOfFieldRef; $0)
C_POINTER:C301(MethodStats__GetPosOfFieldRef; $1)
C_LONGINT:C283(MethodStats__GetPosOfFieldRef; $2)
C_LONGINT:C283(MethodStats__GetPosOfFieldRef; $3)

//BuildNo_SetBuildNo
C_TEXT:C284(BuildNo_SetBuildNo; $1)
C_TEXT:C284(BuildNo_SetBuildNo; $2)
C_TEXT:C284(BuildNo_SetBuildNo; $3)

//BuildNo_GetBuildNo_CodeAnalysis
C_OBJECT:C1216(BuildNo_GetBuildNo_CodeAnalysis; $0)

//Folder_EnsureEndsInSeparator
C_TEXT:C284(Folder_EnsureEndsInSeparator; $0)
C_TEXT:C284(Folder_EnsureEndsInSeparator; $1)

//Folder__UnitTests
C_TEXT:C284(Folder__UnitTests; $1)

//ExportExtras_GetFldrAppendStr
C_TEXT:C284(ExportExtras_GetFldrAppendStr; $0)

//ExportExtras_GetFolderPathsArr
C_POINTER:C301(ExportExtras_GetFolderPathsArr; $1)
C_POINTER:C301(ExportExtras_GetFolderPathsArr; $2)

//CAWindow_log
C_TEXT:C284(CAWindow_log; $1)

//Folder_DeleteFilesNotInSource
C_TEXT:C284(Folder_DeleteFilesNotInSource; $1)
C_POINTER:C301(Folder_DeleteFilesNotInSource; $2)

//Folder_DeleteFoldersNotInSource
C_TEXT:C284(Folder_DeleteFoldersNotInSource; $1)
C_POINTER:C301(Folder_DeleteFoldersNotInSource; $2)

//Array_RemoveElementIfExists
C_POINTER:C301(Array_RemoveElementIfExists; $1)
C_TEXT:C284(Array_RemoveElementIfExists; $2)

//Array__UnitTests
C_TEXT:C284(Array__UnitTests; $1)

//File_isDifferent
C_BOOLEAN:C305(File_isDifferent; $0)
C_TEXT:C284(File_isDifferent; $1)
C_TEXT:C284(File_isDifferent; $2)

//Method_CodeToArray
C_TEXT:C284(Method_CodeToArray; $1)
C_POINTER:C301(Method_CodeToArray; $2)
C_TEXT:C284(Method_CodeToArray; $3)

//Method__UnitTests
C_TEXT:C284(Method__UnitTests; $1)

//Array_TrimLeadingSpaces
C_POINTER:C301(Array_TrimLeadingSpaces; $1)

//MethodLines_CountBlankLines
C_LONGINT:C283(MethodLines_CountBlankLines; $0)
C_POINTER:C301(MethodLines_CountBlankLines; $1)

//MethodLines__UnitTests
C_TEXT:C284(MethodLines__UnitTests; $1)

//MethodLines_CountCommentLines
C_LONGINT:C283(MethodLines_CountCommentLines; $0)
C_POINTER:C301(MethodLines_CountCommentLines; $1)

//MethodLines_GetHeaderComment
C_TEXT:C284(MethodLines_GetHeaderComment; $0)
C_POINTER:C301(MethodLines_GetHeaderComment; $1)
C_TEXT:C284(MethodLines_GetHeaderComment; $2)

//MethodLine_StoreMethodsCalled
C_TEXT:C284(MethodLine_StoreMethodsCalled; $0)
C_POINTER:C301(MethodLine_StoreMethodsCalled; $1)
C_TEXT:C284(MethodLine_StoreMethodsCalled; $2)
C_POINTER:C301(MethodLine_StoreMethodsCalled; $3)

//Method_GetLastModDTS
C_LONGINT:C283(Method_GetLastModDTS; $0)
C_TEXT:C284(Method_GetLastModDTS; $1)

//MethodLine_StructureUsed
C_TEXT:C284(MethodLine_StructureUsed; $0)
C_POINTER:C301(MethodLine_StructureUsed; $1)
C_TEXT:C284(MethodLine_StructureUsed; $2)
C_POINTER:C301(MethodLine_StructureUsed; $3)
C_POINTER:C301(MethodLine_StructureUsed; $4)

//MethodStats__NewDefaultObject
C_TEXT:C284(MethodStats__NewDefaultObject; $1)
C_OBJECT:C1216(MethodStats__NewDefaultObject; $2)

//Structure_FriendlyPathFromPath
C_TEXT:C284(Structure_FriendlyPathFromPath; $0)
C_TEXT:C284(Structure_FriendlyPathFromPath; $1)

//Structure_ParentModuleFromPath
C_TEXT:C284(Structure_ParentModuleFromPath; $0)
C_TEXT:C284(Structure_ParentModuleFromPath; $1)

//MethodStats__RefreshMethodObj
C_TEXT:C284(MethodStats__RefreshMethodObj; $1)
C_POINTER:C301(MethodStats__RefreshMethodObj; $2)
C_COLLECTION:C1488(MethodStats__RefreshMethodObj; $3)
C_COLLECTION:C1488(MethodStats__RefreshMethodObj; $4)

//MethodLine_PushMethodsCalled
C_POINTER:C301(MethodLine_PushMethodsCalled; $1)
C_POINTER:C301(MethodLine_PushMethodsCalled; $2)
C_COLLECTION:C1488(MethodLine_PushMethodsCalled; $3)

//MethodLine_PushStructureUsed
C_POINTER:C301(MethodLine_PushStructureUsed; $1)
C_COLLECTION:C1488(MethodLine_PushStructureUsed; $2)
C_COLLECTION:C1488(MethodLine_PushStructureUsed; $3)
C_COLLECTION:C1488(MethodLine_PushStructureUsed; $4)
C_COLLECTION:C1488(MethodLine_PushStructureUsed; $5)
C_COLLECTION:C1488(MethodLine_PushStructureUsed; $6)

//StructureCollection_AddTable
C_COLLECTION:C1488(StructureCollection_AddTable; $1)
C_LONGINT:C283(StructureCollection_AddTable; $2)
C_TEXT:C284(StructureCollection_AddTable; $3)

//StructureCollection_AddField
C_COLLECTION:C1488(StructureCollection_AddField; $1)
C_OBJECT:C1216(StructureCollection_AddField; $2)

//OB_CopyObject
C_OBJECT:C1216(OB_CopyObject; $1)
C_OBJECT:C1216(OB_CopyObject; $2)

//OB_CopyCollection
C_COLLECTION:C1488(OB_CopyCollection; $1)
C_COLLECTION:C1488(OB_CopyCollection; $2)

//Explorer_MetaInfoFunction_Mthd
C_OBJECT:C1216(Explorer_MetaInfoFunction_Mthd; $0)

//OnErr_Install_Handler
C_TEXT:C284(OnErr_Install_Handler; $1)

//Explorer_UpdateMethodInfo
C_OBJECT:C1216(Explorer_UpdateMethodInfo; $1)
C_TEXT:C284(Explorer_UpdateMethodInfo; $2)
C_TEXT:C284(Explorer_UpdateMethodInfo; $3)

//CA_SaveStructureDetails
C_TEXT:C284(CA_SaveStructureDetails; $1)

//Method_GetTypeFromPath
C_TEXT:C284(Method_GetTypeFromPath; $0)
C_TEXT:C284(Method_GetTypeFromPath; $1)

//Method_GetMethodObjNames
C_POINTER:C301(Method_GetMethodObjNames; $1)
C_BOOLEAN:C305(Method_GetMethodObjNames; $2)

//Method_ReduceToNamesOfType
C_POINTER:C301(Method_ReduceToNamesOfType; $1)
C_TEXT:C284(Method_ReduceToNamesOfType; $2)

//ExplorerWin_MethodUpdated
C_TEXT:C284(ExplorerWin_MethodUpdated; $1)
C_TEXT:C284(ExplorerWin_MethodUpdated; $2)

//Explorer__MethodStatsToExlprRow
C_OBJECT:C1216(Explorer__MethodStatsToExlprRow; $1)
C_OBJECT:C1216(Explorer__MethodStatsToExlprRow; $2)

//FocusOnObject
C_TEXT:C284(FocusOnObject; $1)

//Tokenize_LineOfCode
C_OBJECT:C1216(Tokenize_LineOfCode; $0)
C_OBJECT:C1216(Tokenize_LineOfCode; $3)

//Doa_methodEditorSettingsGet
C_COLLECTION:C1488(Doa_methodEditorSettingsGet; $0)

//Dev_4DprefsFilePath
C_TEXT:C284(Dev_4DprefsFilePath; $0)

//Doa_controlFlowsGet
C_COLLECTION:C1488(Doa_controlFlowsGet; $0)

//Doa_4DcommandsGet
C_COLLECTION:C1488(Doa_4DcommandsGet; $0)

//Xml_ToObject
C_OBJECT:C1216(Xml_ToObject; $0)
C_TEXT:C284(Xml_ToObject; $1)

//LibraryImage_GetPlatformPath
C_TEXT:C284(LibraryImage_GetPlatformPath; $0)
C_TEXT:C284(LibraryImage_GetPlatformPath; $1)

//Explorer_MetaInfoFunction_Struc
C_OBJECT:C1216(Explorer_MetaInfoFunction_Struc; $0)

//XML_AddAttributesToObject
C_TEXT:C284(XML_AddAttributesToObject; $1)
C_OBJECT:C1216(XML_AddAttributesToObject; $2)

//Get_GetCommitNumbers
C_COLLECTION:C1488(Get_GetCommitNumbers; $0)

//UTL_structure2Object
C_OBJECT:C1216(UTL_structure2Object; $0)
C_TEXT:C284(UTL_structure2Object; $1)

//XML__XPathNewSyntax
C_BOOLEAN:C305(XML__XPathNewSyntax; $0)

//UTL_lowerCamelCase
C_TEXT:C284(UTL_lowerCamelCase; $0)
C_TEXT:C284(UTL_lowerCamelCase; $1)
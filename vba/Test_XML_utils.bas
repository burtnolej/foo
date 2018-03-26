Attribute VB_Name = "Test_XML_utils"
Option Explicit
Const CsModuleName = "Test_XML_Utils"
Function Test_CreateCustomUIXMLDocFromArray() As TestResult
Dim eTestResult As TestResult
Dim aXMLElement() As String, aXMLElementAttr() As String, aXMLRootElementAttr() As String
Dim sExpectedResult As String, sSchema As String, sFuncName As String
Dim xDoc As MSXML2.DOMDocument

setup:
    sFuncName = CsModuleName & ".CreateCustomUIXMLDocFromArray"

    sExpectedResult = "<menu xmlns=""http://schemas.microsoft.com/office/2009/07/customui"">" & _
          "<button id=""but1"" imageMso=""Help"" label=""Help"" onAction=""HelpMacro""></button>" & _
          "<button id=""but2"" imageMso=""FindDialog"" label=""Find"" onAction=""FindMacro""></button>" & _
          "</menu>"

    sSchema = "http://schemas.microsoft.com/office/2009/07/customui"
    aXMLElement = Init2DStringArray([{"button","";"button",""}])
    aXMLElementAttr = Init2DStringArray([{"id","but1","imageMso","Help","label","Help","onAction","HelpMacro";"id","but2","imageMso","FindDialog","label","Find","onAction","FindMacro"}])
    aXMLRootElementAttr = Init2DStringArray([{"xmlns","http://schemas.microsoft.com/office/2009/07/customui";"",""}])
    
    Set xDoc = CreateXMLDocfromArray(aXMLElement, _
                                     aXMLElementAttr:=aXMLElementAttr, _
                                     sRootName:="menu", _
                                     aXMLRootElementAttr:=aXMLRootElementAttr)
    
    If xDoc.xml <> sExpectedResult & vbCrLf Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_CreateCustomUIXMLDocFromArray = eTestResult
    
End Function

Function Test_CreateXMLDocfromDict() As TestResult
Dim sFuncName As String, sExpectedResults As String
Dim eTestResult As TestResult
Dim dTmp As New Dictionary
Dim xDoc As MSXML2.DOMDocument
setup:
    sFuncName = CsModuleName & ".CreateXMLDocfromDict"
    
    
    dTmp.Add "foo", InitVariantArray(Array("bar"))
    dTmp.Add "bar", InitVariantArray(Array("foo"))
    dTmp.Add "foobar", "barfoo"
        
    sExpectedResults = "<root><foo>bar</foo><bar>foo</bar><foobar>barfoo</foobar></root>"
main:
    Set xDoc = CreateXMLDocfromDict(dTmp)
    
    If xDoc.xml <> sExpectedResults & vbCrLf Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_CreateXMLDocfromDict = eTestResult
    
End Function
Function Test_CreateXMLDocfromArrayWithAttributes() As TestResult

Dim sFuncName As String, sExpectedResults As String
Dim eTestResult As TestResult
Dim aXMLElement() As String
Dim aXMLElementAttr() As String

Dim xDoc As MSXML2.DOMDocument
setup:
    sFuncName = CsModuleName & ".CreateXMLDocfromArrayWithAttributes"
    
    aXMLElement = Init2DStringArray([{"tag1","foo";"tag2","foo2";"tag3","foo3"}])
    aXMLElementAttr = Init2DStringArray([{"attr1","attrval1","attr2","attrval2";"","","","";"attr3","attrval3","",""}])
                       
    sExpectedResults = "<root>" & _
                       "<tag1 attr1=""attrval1"" attr2=""attrval2"">foo</tag1>" & _
                       "<tag2>foo2</tag2>" & _
                       "<tag3 attr3=""attrval3"">foo3</tag3>" & _
                       "</root>"
                       
main:
    Set xDoc = CreateXMLDocfromArray(aXMLElement, aXMLElementAttr:=aXMLElementAttr)
    If xDoc.xml <> sExpectedResults & vbCrLf Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_CreateXMLDocfromArrayWithAttributes = eTestResult
    
End Function


Function Test_CreateXMLDocfromDictMultiValues() As TestResult
Dim sFuncName As String, sExpectedResults As String
Dim eTestResult As TestResult
Dim dTmp As New Dictionary
Dim xDoc As MSXML2.DOMDocument
setup:
    sFuncName = CsModuleName & ".CreateXMLDocfromDictMultiValues"
    
    dTmp.Add "foo", InitVariantArray(Array("bar1", "bar2"))
    dTmp.Add "bar", InitVariantArray(Array("foo1", "foo2"))
    dTmp.Add "foobar", InitVariantArray(Array("barfoo"))
        
    sExpectedResults = "<root><foo>bar1</foo><foo>bar2</foo><bar>foo1</bar><bar>foo2</bar><foobar>barfoo</foobar></root>"
main:
    Set xDoc = CreateXMLDocfromDict(dTmp)
    
    If xDoc.xml <> sExpectedResults & vbCrLf Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_CreateXMLDocfromDictMultiValues = eTestResult
    
End Function

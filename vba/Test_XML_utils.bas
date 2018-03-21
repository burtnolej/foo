Attribute VB_Name = "Test_XML_utils"
Option Explicit
Const CsModuleName = "Test_XML_Utils"

Sub TestRunner()
    'GetLogFile
    Log_Utils.LogFilter = "8,9"
    Test_CreateXMLDocfromDict
    'Test_CreateXMLDocfromDictMultiValues
    
    Test_CreateXMLDocfromArrayWithAttributes
    Test_CreateCustomUIXMLDocFromArray
    'GetLogFile
    
End Sub

Sub Test_CreateCustomUIXMLDocFromArray()
Dim bTestPassed As Boolean
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
        GoTo fail
    End If

Success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    
End Sub

Sub Test_CreateXMLDocfromDict()
Dim sFuncName As String, sExpectedResults As String
Dim bTestPassed As Boolean
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
        GoTo fail
    End If
    
err:
    GoTo Success

Success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    
End Sub
Sub Test_CreateXMLDocfromArrayWithAttributes()

Dim sFuncName As String, sExpectedResults As String
Dim bTestPassed As Boolean
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
        GoTo fail
    End If
    
err:
    GoTo Success

Success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    
End Sub


Sub Test_CreateXMLDocfromDictMultiValues()
Dim sFuncName As String, sExpectedResults As String
Dim bTestPassed As Boolean
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
        GoTo fail
    End If
    
err:
    GoTo Success

Success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    
End Sub
